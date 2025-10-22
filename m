Return-Path: <linux-kernel+bounces-865403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F18BFCFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BE354EBEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0B258ED6;
	Wed, 22 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simplelogin.com header.i=@simplelogin.com header.b="TcTfEmai"
Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589A25783F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148733; cv=pass; b=GZUgajFiiBKuux871LTbclolYXZT3l8burUmvmOj4PMqbWH8C7SH96CXEaCpUZzuaDNsMmR7w4ukxQ6HfpEC+HILkZxik5xWmn93DVm1r3Ugh17nrEz6Mbv6m/guNhBKhwDGE4Wns3PEX1mUasjM8ge7QieuXR40WsulnyUPav4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148733; c=relaxed/simple;
	bh=faGT9NsG/iSiUT0Yjw752Nox5X1CkYE1lvm+hwuJd0w=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=BMc5/fwuBLY7vRYrYWKCoCh6ZRthaC7JblABRjNngL7MPn9+58O5ugtaHXJSzHVeAV4luxa8ZynFEIu7TSmsLLnTIWIRhICOFHpytuMQw7wJMOb8QiaMUq8uoezfhW2dLpSmsz0pnUv2N983TaeLeRwkuNuAOBX3OW+hGRs3KRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simplelogin.com; spf=pass smtp.mailfrom=simplelogin.com; dkim=pass (1024-bit key) header.d=simplelogin.com header.i=@simplelogin.com header.b=TcTfEmai; arc=pass smtp.client-ip=176.119.200.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simplelogin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simplelogin.com
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1761148724;
	cv=none; b=L+aF3Rx8HLMep55YgESv/mIugQFMepaYGxQGszg2ZotpO27jwbgpKcTeR9XeVPuQ5l8CeuQM9NEXcAHv1vdKL5VWsoB0/Snnju6blLvvuHluyAyXuFL+BnZocsmz3MDE10XdM22CP9QcKRZz+8K6Eadplg3WErBGXrAotWxWEL4vfrBcl2lnj6vLoLrWNekvDcbN8Unc0ktKlRcp46zotA4wUP+7X5IeMrAvC5pRt79FkMVRMWJum63TuPiccnbO7qwD37+CxqWOjcOcPuFv4vwIIGQm0LlJkGpfvUVaurgryZxQuU0/aCIY944mT+RvoKmlD5DmhWwBTkgahAYtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1761148724; c=relaxed/simple;
	bh=faGT9NsG/iSiUT0Yjw752Nox5X1CkYE1lvm+hwuJd0w=;
	h=Date:Subject:From:To; b=B5ERKNdo5lKSiYbk37kH4woCHRbVS/pYHFwdu/KVm8+VRaWfmURrM9KydBaMj1FgXXDN9uFFHS6zkTrjhVzkOKiRgN1JMcIPUAeUkADFGVfMtPmKHVTM+mfg9q/mrfBXn85ogayKXxMe9onrZTIchLsAxHsm1BIlrAw8d6tqcLr6ZE/R+si7U3nqBLMLdpF632fQFqSukuTlhQ0tMcIbD9nfWASO/ud0lnNvntFiKmI/Q9zdh3rjWMnnEmsokFEUiUiJha0w3ugVkFrYOqfmeDs7lCB1tR8Uxtj4BIyMrC94YxV8+va9q9IBL5WipAy+UauDgF2F0jZqJVhJR+DYnQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simplelogin.com;
	s=dkim; t=1761148724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faGT9NsG/iSiUT0Yjw752Nox5X1CkYE1lvm+hwuJd0w=;
	b=TcTfEmaiTL28WArMD9yEN9WAAs16w58109OE1QatveWigxN4aQKOQXTMigIJBLYXfyv2tl
	MYEDehnwbi0GUEXqYH/K5r22vHG8tjUYzvTwr//6qsjPLeRFo6Z5BDemVWmq4B7/9BATfr
	bBDBQNFbTP2CT1otuy8dmfrt+wQyxwQ=
Date: Wed, 22 Oct 2025 15:58:38 +0000
Subject: Kernel and Anti-Cheat Suggestions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: sender.ovzss@simplelogin.com
To: linux-kernel@vger.kernel.org
Message-ID: <176114872374.8.14068467571033879083.966530839@simplelogin.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 966530839
X-SimpleLogin-Want-Signing: yes

Hello Linux Kernel Developers Team,

I'm not sure if I'm emailing the right place. What is the probability that =
what I'm writing will happen?

For all games to run flawlessly and receive official support on Linux, seve=
ral key technical, structural, and economic changes would need to happen.

A unified and standardized Linux gaming platform

Currently, there are hundreds of Linux distributions (Ubuntu, Arch, Fedora,=
 Debian, Pop!_OS, Manjaro, etc.), each with different kernels, drivers, and=
 libraries. This makes consistent performance and stability difficult for d=
evelopers.

A single standardized runtime layer=E2=80=94such as Valve=E2=80=99s SteamOS=
 and Proton combination=E2=80=94would make it easier to target one common e=
nvironment. If all major distros aligned under a =E2=80=9CSteamOS-compatibl=
e=E2=80=9D certification, developers could build once and support all users=
 more easily.

Kernel-level secure sandbox or anti-cheat API

Anti-cheat systems like Riot Vanguard, BattleEye, and Easy Anti-Cheat requi=
re kernel-level access to verify system integrity. On Linux, differences in=
 kernel modules and root permissions create security and compatibility issu=
es.

A secure kernel interface or sandbox API designed for anti-cheat systems (s=
imilar to Windows=E2=80=99s Protected Game Mode or macOS=E2=80=99s System I=
ntegrity Protection) would allow anti-cheats to safely verify the system wi=
thout intrusive kernel drivers. This would eliminate one of the biggest bar=
riers to Linux gaming support.

Unified and stable GPU driver ecosystem

Games behave differently on NVIDIA, AMD, and Intel hardware due to varying =
driver quality and compatibility. Closed-source NVIDIA drivers often break =
after kernel updates.

To solve this, GPU vendors need to fully support the same modern graphics A=
PI=E2=80=94Vulkan=E2=80=94and maintain a stable ABI (Application Binary Int=
erface) between the kernel and drivers. Consistent and open GPU support wou=
ld make Linux gaming as reliable as Windows.

Official DirectX to Vulkan compatibility (or full DX12 support)

Most Windows games use DirectX 11 or 12, while Linux primarily uses Vulkan =
or OpenGL. Compatibility layers like Proton and DXVK translate these calls,=
 but not perfectly.

If Microsoft provided an official Vulkan backend for DirectX, or if game en=
gines like Unreal, Unity, and RE Engine made Vulkan their default renderer,=
 games could run natively on Linux with little or no translation. Once the =
DirectX=E2=80=93Vulkan bridge is seamless, there will be no real =E2=80=
=9CWindows-only=E2=80=9D barrier.

Official Linux Game SDK and testing infrastructure

Developers currently face a fragmented testing environment: different distr=
os, drivers, and libc versions.

An official Linux Game SDK=E2=80=94similar to Xbox GDK=E2=80=94would give d=
evelopers a stable target, such as =E2=80=9CLinux Game SDK 1.0 (kernel 6.10=
+, Vulkan 1.4+).=E2=80=9D If Valve, Canonical, Red Hat, and System76 collab=
orated to provide this along with automated CI/CD testing support, developi=
ng for Linux would become as simple as developing for Windows or consoles.

Economic incentives and market growth

Only around 2=E2=80=933% of gamers use Linux, according to Steam statistics=
. Studios are hesitant to invest in porting and support for such a small ma=
rket.

However, the rise of Steam Deck and Proton is expanding Linux=E2=80=99s sha=
re. If the Linux gaming market surpasses 10%, developers will begin to supp=
ort it naturally. Valve and other major players could also offer funding, v=
isibility, or certification incentives for Linux-native games.

Standardized security and integrity verification (Secure Boot + TPM)

Anti-cheat systems must verify that a system=E2=80=99s boot process and ker=
nel haven=E2=80=99t been tampered with. Linux distributions differ widely i=
n bootloaders (GRUB, systemd-boot) and Secure Boot/TPM configurations.

If Linux standardized kernel module signing, TPM-based integrity, and Secur=
e Boot behavior for =E2=80=9Cgaming mode,=E2=80=9D anti-cheat systems would=
 finally be able to trust the Linux environment without special exceptions.

In summary:

To make Linux a first-class gaming platform where all games run smoothly an=
d securely, the following conditions are needed:

A unified Linux runtime or standard platform (like SteamOS)

A secure kernel-level API for anti-cheats

Stable, unified GPU drivers with Vulkan as the main API

Full DirectX=E2=80=93Vulkan interoperability

An official Linux SDK and CI infrastructure

A larger player base with developer incentives

A standardized Secure Boot and TPM verification chain

Once these areas mature, Linux could reach full parity with Windows in gami=
ng=E2=80=94both technically and commercially.

Good Jobs Dear Linux Kernel Developers Team


