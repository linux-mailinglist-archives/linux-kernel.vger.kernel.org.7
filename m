Return-Path: <linux-kernel+bounces-791491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103BB3B78B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB63A4846
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063582C11CF;
	Fri, 29 Aug 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="O9RLlRfc"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EE2F3636;
	Fri, 29 Aug 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459803; cv=none; b=Oo1eG+F9gvSklUN8keobP8wTAfjQAigjEDUz9tATkHPCUBLqNF23TT0bATGGza4iEEPrcl7AYAlVKJbed5ZPZeEgCtha0hDL1z1loTZMwEv2aePRylwpCah1MN1JHZi4glWD9e4fEFmRtPz/BUIkFySN7Ojbizwt9dUa3QHcV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459803; c=relaxed/simple;
	bh=Kbb0zO07TWKOgAWnfOJ5eGnqTBUdk2BTH1xaneKkpwE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=agHJHuPjcd36THNf8andOzUGMuc7pIOH+SNkWvqFkrJmAm5n5gwfuzOQEuK9e4yMIkyCM1l5BNPkcOhj7o735p6NF8ixsgX0JsE7T8duQpMQ8j0gJos1L6J+N7nrM4fKqKdR19GPlTdfuhz69rUtd2eaXfWje+j2oFYtJF/TymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=O9RLlRfc; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756459775;
	bh=Kbb0zO07TWKOgAWnfOJ5eGnqTBUdk2BTH1xaneKkpwE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=O9RLlRfcCJV1haw/mJQNo9/SArdeAnJN96kn38sxSGL7mkE7DuCrV5x4y1Qnhh9e+
	 40AnjAeSsmNe+aJZovxoe1DQ1ydzn3WsxltjBPXj9LZEWbzIKZ00r4lcxqJwJLdS7E
	 jVT72xkKPurbWd/HnDJn/P52F15nYpRaMew0YdGA=
X-QQ-mid: zesmtpsz5t1756459764t24e88756
X-QQ-Originating-IP: K3fxIcND9xVU396Ni2vHkM3OCrJJ2bM2OHyoxQ3IHZg=
Received: from [192.168.15.210] ( [103.152.35.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 17:29:22 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1035626945351233096
EX-QQ-RecipientCnt: 11
Message-ID: <C22C1A172EBB9BD9+eccc2e4a-d21e-4a7d-848c-bbf3982feb94@uniontech.com>
Date: Fri, 29 Aug 2025 17:29:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>,
 Feng Yuan <fengyuan@uniontech.com>,
 Cryolitia PukNgae <cryolitia@uniontech.com>, qaqland <anguoli@uniontech.com>
From: Cryolitia PukNgae <cryolitia@uniontech.com>
Subject: [RFC] sound: usb: design for quirk 'mixer_min_mute'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MIXpHopat2IaOpNcAuVGIBGvY9lpwwwsbCi0frLC47CxZYfkkV2RlyTJ
	HA1/6lqKuDG1pTkCsrOzezOD+IrIO5BDGRdmzhN5ETZku2dPTQCRwlT1+7qeSi8GJRAIR08
	SFvRUCXsTDlrL/+QEZIWjoVfdtUx10UFOWSLQCipemXJgLkETULpkgWSHqkQBiu2Fk7/oJW
	BfKZWWqztav15siXXqmkmeeuR1ZheXBbHGMnqDDcjaMWP/L2j9dFDZXo8cUkAUDBbEdAkFS
	i7y2BIGa7WQDrID17jg/x5etshCF6mQ5Aha/24R64B2DZ3QYDZQy6m4KttApx8dThfYU5gg
	/y00V2ue7KYm/B5ZAjVT9SOE8EwwguzTFW06vY1H7Lz1RXy/IYEWtRdimTusrx5A3bFtEtV
	SIvlc25vouKT77sFAB+KAsqxaAhQ9kpQ22VfZ0oDhh6Hh/N/jWum9dpWa5mPelypLfUROhn
	QXkWRDK1fESJBIY9BtEpNkKAWhXrLlySyW7oR4I3xsF2MO9Ssg2q3OIUM0FI6NRc5HCe0Oo
	uqwnKKq1iEE4PJYwjtjoduwNNGRu/ShY+Ryt2WR2+CC1TtGlljKRP/iouSkWMAaJVtvAFJ9
	xsJAx2W+Y0I5QqDfTDln1wL6QYZsfsgoqaUHP5ked+g1fMe4UysBymJ+OPL8MbV6eo3x+Un
	KqILiYdk4+cTHZgy+3v+/0F+beMPYJ200h+h/BdLLwUkXxdiaxgg5es6PiTig15KKXEHlr6
	bRUHWTMvHnAWlCMlLEvwdluwidk22Zqn2EQiXPP3n/YCI1x530/DPvAgLs/ER343SVAuYtG
	BncWkb+iUOtAZHdbfwgMMSE5bHrDGvdSVlqwmt0IgHnrL9W371H+pWv6IZ/SR+UvrUQpPsC
	uAQfTcrNOmIiqIt7dkTaHnwgjgENRBif802fLldFi/B0h1C6jaTSnfRtdaJU9ojm5UiJFso
	t5r4BBYbKFWoi7Beh/irF8E4s97IWjAWw/mvt11xh4YgpzJVUMlIWtzY4AFKGomZxhIWVZF
	41Bbm0hVFdDLJDoEFmoI1tMXCuMDe9DwIPl380Fq8KkagS9XBsa31Qn9EXA3FH5vKQMdpbF
	jmKEqBYlOIT
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

We are discussig about the problem that, on some devices the lowest
playback value represents muted state instead of minimum audible volume.
In the previous discussion, we have shown that this problem is widespread
across a wide range of hardware[1][2]. And we have already added a bit for
it[1].

Firstly, we need to discuss about how to design a module param for it. As
it is needed to debug the device for end users instead of ignoring
hardware mixer and using soft mixer only in pipewire, which has already
written in Arch Linux wiki[3], as an imperfect workaround.

Inspired by Takashi Iwai[4], I would like to design a module param named
`quirk_names`, to be passed like
`1234:abcd:mixer_min_mute,4567:efef:ignore_ctl_error`, so that we can
apply one or more quirk on a specific USB device. And the already existed
param `ignore_ctl_error` could be deleted, because of included in the
one.

>    /* lowest playback value is muted on some devices */
>    if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
>        if (strstr(kctl->id.name, "Playback"))
>            cval->min_mute = 1;

Secondly, all efforts so far is only for the Playback. But we have found
some devices have the same problem on the Capture. So for the problem
that the lowest playback value represents muted state instead of minimum 
udible volume:

  1. On some devices we already tested, only happens on their Playback,
     but their Capture works perfectly. Or they are just a simple
     earphone without audio input.
  2. On some devices we already tested, have the problem both on Playback
     and Capture.
  3. Maybe on some devices we havn't found yet, have the problem only on
     Capture but not Playback.

How could we deal with them? Would two quirk bit seems a little waste?

Thirdly, the most complex situation. We found a device: `3302:12db
MOONDROP Quark2` , that its volume control has a range 0-120, but acts to
mute when less than 8. I have no idea about how to deal with it simplly.
We are actively contacting the manufacturer and informing them of this
matter.

I sincerely hope that my poor English explains the current situation clearly.

1. https://lore.kernel.org/all/20250827-sound-quirk-min-mute-v1-1-4717aa8a4f6a@uniontech.com/
2. https://lore.kernel.org/all/20250829-sound_quirk-v1-1-745529b44440@uniontech.com/
3. https://wiki.archlinux.org/index.php?title=PipeWire&oldid=804138#No_sound_from_USB_DAC_until_30%_volume
4. https://lore.kernel.org/all/87bjnyimu9.wl-tiwai@suse.de/

Best regards,
Cryolitia PukNgae <cryolitia@uniontech.com>

