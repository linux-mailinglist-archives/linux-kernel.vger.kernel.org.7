Return-Path: <linux-kernel+bounces-769459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A42B26EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DEBC4E3E63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C822AE65;
	Thu, 14 Aug 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hue/kGCk"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA831984B;
	Thu, 14 Aug 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196467; cv=none; b=q1ovusWx/hhblGNToTkVDPOk6M/qsKCqo4NejIVUqvPOEV93414t1A+wsifULrV+UoyAsbyjWAEXZHzeEAaxOS+D44xh6T+A6wuIalmka/W8uE2KB4Th4s/w407YWYHaYi3tkJEXgw6OCTeIDkJJzAO7j4YkR+u8ErC+h0oUcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196467; c=relaxed/simple;
	bh=FSLiHd375EHuoDX0HzaYJ70AvyrFdH1Xo8tKcLu376g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a40rxTXCPdWhjJsdNClasdBMh4zD1FSUB0mMOiHDBw+PZgVxmM3aqOB/v5qmr/Ne6ZrhFUAbeOuOO/U7rwWAldGbo0Z0B9dFKrpDsd2fT/TCrr5c/HgKBknlab89/OPJbRz+Buup/lZvv7am/za5mFzAa1voAbACmZqdyJJOpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hue/kGCk; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88432ccff13so32409739f.0;
        Thu, 14 Aug 2025 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196465; x=1755801265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDFSf6VtpPHSRKcxIyA+1BMA+HuzuiTfla7h2FaLgn0=;
        b=hue/kGCkIN+YawZQ5VX9WRf7F4ybeJ+lM31MYPo+HjGdps7vre+uRPgGvy6Qtnp5uo
         OVBY7fQq5dFFNbleDSG9lzpYMJ5CnkZ6XZpshcmso5KDpa1PhazsL0X+yCR1UQh2oPKJ
         0pvX6vrSc7BRWraDV3fJGmWPKCgRsCg4LXEJzLGTOMQ+oZk2/ZdIebpu8GP2ogAQctei
         FRQpFfmVPYN1jJjMm0JsxqELfawzhfGr3OxmuY8k0K0iMDUUQFqzNxixMg3IcbTV3xiH
         /CFvHr6OjZO75bmY1TGL+xuYd8QU+IyQZWpwB1XcPkiGx2C9Z8vYhac25wRQUqrKO+a9
         3fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196465; x=1755801265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDFSf6VtpPHSRKcxIyA+1BMA+HuzuiTfla7h2FaLgn0=;
        b=Kck82rVmGsH5NUANvtxCxC2eANKK9scJvkGrPVTTQZec24LfJXeVRJsiS8Cuf/DUR9
         E9ZCJIVPjUVpjRppb9L45rOebBIWguecrcmyb/xCvvc2kiUHT+Nlz9J+5xXJvbNY1swG
         ttdFSe8Ff/XrhMGLFFDI9n2uN9dZNq7TRVC024cr399ATMHxSdpku2XXiBdSBozdSa+2
         /cHYRSUAvbLKgAPKLTwESvuxSxfXThv/Sr2yiV/4/k522PH4ZzyHRcya5iXOUjJa0qVs
         8md3E4f5deKT1QrLUaoaKmLjsxHgGzSncMeY+VvZ+foKBuiByTHYWdsvOiLR8ugwm1aG
         RoKg==
X-Forwarded-Encrypted: i=1; AJvYcCVmzwq25PQpcZj/cplZlXp9n9HuUT0aJ2PJhoZWQsUe/xUZiuK7vM8STXcG6X7fJgs478Grxc99L7jhovI=@vger.kernel.org, AJvYcCWWWZn9TX1NMCOSsz2xIeYIqQj89+/V3VY+Tvc7v3fkNRCPP8MAwlmfejIxNNDw9t8fSir7S1cDzv30550=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETE6dOKlBr5c+66Fa5YEcYh0j0ECKSUY0GrUF7Dc7GFyiR16H
	kVs3HZQl4Km71d2v1uESgr4ftryUK/VeqqUXkHJt8CHmF9HbHSRG8CE4UBLrglJy
X-Gm-Gg: ASbGnctVEMhje5Qujoc8acH+z42ONySSBlsyDjVbUGnbW/i+UUGsR91u/OcHL9Mqzxw
	X+D9tySYAlZNPytroq/d78Xctuqwc10fM4MY8VzRsBd1N1tWJj2kRSl8HZCWJySt1QKhTqOsRwo
	FN7GE2Ou+9vXHyZ0Ia3sNzDTQi+B+pIj7i6rgsF+blpO62dquMvLLrWMyTliiDirz2W7ZOSwr2I
	I6Lbwv/0W2OP3BfYH20zfPOkRZc/r/eXleqyLxnM1jQdE0+fFApapIuXYBB9L5wCc6MAPEdDhHu
	D9vh0vrCirQBf5AkfdttkJcUQz1frYP9YFYcwTDCk+hDFVHFEhQFrGQc6jMdGNgrQb0Q5kDLD9g
	fnp5fDFmfxI8meSA1EVNc/mzwuPThQJItPrwIxOQxYVDcLzhnmNk+2TmAGpRhjXKAO5w=
X-Google-Smtp-Source: AGHT+IHfccetpow7yjMs7GtNWYKROF86+lwcaLN319Y0r24RCbYznZE4qD/w6tAWLRU5bGeNyjBvTQ==
X-Received: by 2002:a05:6602:14cc:b0:875:95b7:c0d6 with SMTP id ca18e2360f4ac-8843cc87b3amr23726439f.2.1755196461884;
        Thu, 14 Aug 2025 11:34:21 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f18d1cabsm562086039f.8.2025.08.14.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:34:20 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	shimrrashai@gmail.com,
	tiwai@suse.com
Subject: Re: Re: [PATCH 1/2] ASoC: es8323: enable right-hand DAC-mixer connection on ES8323
Date: Thu, 14 Aug 2025 13:33:44 -0500
Message-ID: <20250814183344.59453-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b5a64166-c55f-4ca4-af92-52c954847af6@sirena.org.uk>
References: <b5a64166-c55f-4ca4-af92-52c954847af6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 14, 2025 at 01:11:59 PM +0100, Mark Brown wrote:
> On Wed, Aug 13, 2025 at 08:47:31PM -0500, Shimrra Shai wrote:
> > Enable the right-hand DAC mixer connection in the same manner as the
> > left-hand one.
>
> > @@ -633,6 +633,7 @@ static int es8323_probe(struct snd_soc_component *component)
> >  	snd_soc_component_write(component, ES8323_CONTROL2, 0x60);
> >  	snd_soc_component_write(component, ES8323_CHIPPOWER, 0x00);
> >  	snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);
> > +	snd_soc_component_write(component, ES8323_DACCONTROL20, 0xB8);
>
> Neither of these should be unconditional writes, these should be user
> visible controls.  We don't encode specific system's use cases into the
> driver.

I was just following the precedent from the driver's prior
author(s), in the manner of the line above it. Presumably, enabling
the left-hand DAC-mixer connection only was a solution that worked
for some devices, and theoretically (as in, I don't know of them
personally), there could be devices where enabling the right-hand
DAC-mixer connection only works for them (the Firefly may be just
such a device; I have only tested it with both enabled at once,
so I can't say for sure. I know it definitely does not work with
the left-hand connection enabled alone, i.e. the line preceding
my addition). And perhaps also devices where there is some kind
of cross-inhibition effect, meaning setting both enabled would
generate problems on those devices, thus justifying your concern
instead of using a blanket for all devices as I thought. In that
case, that means the original author was also wrong, and so I need
to know exactly where it should be placed.

With regard of that though, I see these lines earlier in the driver:

/* Left Mixer */
static const struct snd_kcontrol_new es8323_left_mixer_controls[] = {
	SOC_DAPM_SINGLE("Left Playback Switch", SND_SOC_NOPM, 7, 1, 1),
	SOC_DAPM_SINGLE("Left Bypass Switch", ES8323_DACCONTROL17, 6, 1, 0),
};

/* Right Mixer */
static const struct snd_kcontrol_new es8323_right_mixer_controls[] = {
	SOC_DAPM_SINGLE("Right Playback Switch", SND_SOC_NOPM, 6, 1, 1),
	SOC_DAPM_SINGLE("Right Bypass Switch", ES8323_DACCONTROL20, 6, 1, 0),
};

which suggest it is in fact controllable already, but I wonder why it
is in the "bypass" switch only and not the "playback" switch, which
seems to do nothing (SND_SOC_NOPM). Would it perhaps be correct to
move these to the "playback" switch, or to have both switches
collapsed into a single switch?

In any case, if these are the correct places to enable this control
and it is already supported there, then it seems neither write command
in the setup is needed, viz. we should _delete_

snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);

too. What do you say?

  Thanks for any feedback,
  Shimrra Shai.

