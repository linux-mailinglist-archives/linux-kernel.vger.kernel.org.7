Return-Path: <linux-kernel+bounces-815063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5DB55EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2DA02B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C972E718B;
	Sat, 13 Sep 2025 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mz3+u3XE"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536872631;
	Sat, 13 Sep 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744237; cv=none; b=ixDEBaQa454zfhrA9xTLqPcLEwj2KM6L9rwRyR2aVuJ+maiI2zlkm4pmsn7sEewi1WsS1iaDJIe3OjU1mL3CxP68JO4xM0qly1b/dovxTvxp1lKnW+wPorCewnj34l5WukcqR6zK7BRT36RN87hPmNcyn7y2IkNBO9o7dYWccuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744237; c=relaxed/simple;
	bh=+sVSooUBBEwVcYeGMJ5TWvGle0MXNQMVWEFRKFJeIoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtLw6aghtiLeWasKOtQh4Xnl9Xb0Qof/FGSw54k/r8CiNV+eihrnocPljuymi5MDaBWrVyNwNoSu5pkmTzzox4vazoN6zDDrXnPRPEkXnX6ws7pHOjkCILPJQ02IOdpQ2fHur7zDSA326Qmt0riVCo9/wj7zaoCLGxMEoEUYrEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mz3+u3XE; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757744226; x=1758349026; i=markus.elfring@web.de;
	bh=jyPpWZ8GRasyTxye3NOHL/OPFN0KiDvvNkc7VnG0JZ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mz3+u3XExM3XW04+wucVDZGMptbjhAMTeckLd/na0TePVjMfS0RRuAQSe+FuoOta
	 3tZnZRccsx8G8LMU0hQ1Ltd7u7Vjw6iYxkzlBoGUQnaVgIB2J0Sx3f0NLUfT1vfK2
	 wUrtXB23r8aADQQG9LIXnlWA+5Kp0sbOxWkbSMoQk5FDHwS/Apq4T7vxrb1ErQ5Uj
	 RriAUmWNADJZNdJOs3+BsvuKbZM262qJle6+G9sZkt516kkoEFbCWvtudVclYQc+U
	 xXFGuIfScodHb4X7QhLz1gA0WDzm361Wnuy6M8tDXBCwexJ6dO+k2EYOgDtdSK8TQ
	 sKAcI8lB8FJIZhrGLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.217]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LEG-1uIs4B2LqO-00x5v4; Sat, 13
 Sep 2025 08:17:03 +0200
Message-ID: <f8726808-9e34-44b5-b6e2-27e898c53321@web.de>
Date: Sat, 13 Sep 2025 08:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
To: Daniel Lee <dany97@live.ca>, platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matan Ziv-Av <matan@svgalib.org>
References: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <37610abe-e6ea-4694-be63-1a7147c52b73@web.de>
 <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:twv47pQ9G7wXIvv8tNpfDT1FAuyzVnIJydjNEmbEmqFaXK5GJCF
 9l1AHs/2kfzC5fnxCjEXPd5MgpgXfvzQMbEB1FyHWxHWqAfZvLlfxBlIsK93QPkIExOv30R
 tom0Sl7VGRlNLhpm9pb8CiP6tBl1FFrn1ZRRMluqbeYMmNzDHs904dqruLesTnO3d0GPMMn
 1XDJq27Wyfk0Kyd4kdjsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bfjffRwbWS0=;xZQ3HEw2nF2/sK4sLI2ES+O85Zs
 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

=E2=80=A6> ---
>  .../admin-guide/laptops/lg-laptop.rst         |  4 +--
>  drivers/platform/x86/lg-laptop.c              | 29 +++++++------------
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n310

Regards,
Markus

