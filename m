Return-Path: <linux-kernel+bounces-773723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA29B2A717
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02037A75D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805F3218B2;
	Mon, 18 Aug 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b="VK586F9x"
Received: from thor.imp.ch (thor.imp.ch [157.161.4.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15886279351
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.161.4.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524724; cv=none; b=ZcJzOMh0M5vjPiZnw6FSkK8B4ga6lTiX3zemQnFZC/WyOiJsXow8/Ro8YvDr979DtywRbv7kSxJ7XH92GfgAvSb11rkIDmLJG13evJq1DAPbmFrody5dU+q9vGGOQZYbTYtuV5sNVR9HPiQ0LfRQBUzXM4YMqsYwqR30ar3B/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524724; c=relaxed/simple;
	bh=By96cjTuNZjb6N982SGqiWCH6ewfg4bvR6HPHWbInio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnwy7HnjME+5Ao60tNKhfrdZZeg+ubMdwUp5gqOBdoeJOPGVz3VxpwF1yyN8P+SWLQQksmEVPS009boPtD+bmXZ4UJ99+sr6UoJ3965P8AzvPPzap9DFNt1yP8Sztg3BWdOXDSBeezjAIQfbIZL9w4jljc0zq1Y8msRrfH0WnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch; spf=pass smtp.mailfrom=imp.ch; dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b=VK586F9x; arc=none smtp.client-ip=157.161.4.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imp.ch
Received: from go.imp.ch (go.imp.ch [IPv6:2001:4060:1:4133:f8d3:e3ff:fee7:5808])
	by thor.imp.ch (8.18.1/8.13.3) with ESMTPS id 57IDIEB4067261
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 18 Aug 2025 15:18:14 +0200 (CEST)
	(envelope-from benoit.panizzon@imp.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imp.ch; s=mail;
	t=1755523095; bh=By96cjTuNZjb6N982SGqiWCH6ewfg4bvR6HPHWbInio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VK586F9xL2Tk1VVUA4sKWlizoCjv5OVasNy6G3VWIx+ZKP4u3ro/pY7IfVK7xKtCB
	 jGnLQWr5FshJQVEYTXovnHfRLvUS4K5B7Hc7x/fghHWNGv2/VjWO3neczr1rz43pGy
	 e9FBfeMgO29RFzkDdn8R/aqwKkYbq6G1cnA8nkHk=
Date: Mon, 18 Aug 2025 15:18:14 +0200
From: Benoit Panizzon <benoit.panizzon@imp.ch>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
        David Howells
 <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benoit Panizzon <bp@imp.ch>, 1111455@bugs.debian.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [bp@imp.ch: Bug#1111455: linux-image-6.12.41+deb13-amd64:
 kernel BUG at fs/netfs/read_collect.c:316 netfs: Can't donate prior to
 front]
Message-ID: <20250818151814.18d5dcd4@go.imp.ch>
In-Reply-To: <aKMdIgkSWw9koCPC@eldamar.lan>
References: <aKMdIgkSWw9koCPC@eldamar.lan>
Organization: ImproWare AG
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Salvatore

> A user in Debian reported the following kernel oops when running on
> 6.12.41 (but apparently as well on older versions, though there were
> several netfs related similar issues, so including Max Kellermann as
> well in the recipients)

Thanks for looking into this issue. 6.1 from bookworm did not crash
since this morning.

Installed 6.16 from debian experimental - just the linux-image package.

Linux go 6.16-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.16.1-1~exp1 (2025-08-16=
) x86_64 GNU/Linux

Running cachefilesd, /home on NFS

25 minutes uptime. 6.12 would for have oopsed before. Mostly in the
first 5 minutes.

I have upgraded several machines from Bookworm to Trixie - some make
use of NFS but none as heavily as my office workstation with /home on
NFS. All the other machines are either on ARM or INTEL metal or
virtualised KVM machines. Not seen that issue on those other machines.

I suspect it could be a problem affecting only that specific CPU indeed
hitting an invalid opcode.

vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 PRO 5750GE with Radeon Graphics
stepping	: 0
microcode	: 0xa500011

Mit freundlichen Gr=C3=BCssen

-Beno=C3=AEt Panizzon-
--=20
I m p r o W a r e   A G    -    Leiter Commerce Kunden
______________________________________________________

Zurlindenstrasse 29             Tel  +41 61 826 93 00
CH-4133 Pratteln                Fax  +41 61 826 93 01
Schweiz                         Web  http://www.imp.ch
______________________________________________________

