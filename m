Return-Path: <linux-kernel+bounces-746667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB0B129D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A03C16EA55
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB90224AE8;
	Sat, 26 Jul 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYnwZhGq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282121A428;
	Sat, 26 Jul 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521070; cv=none; b=NXWehTAoUOX804VT254QL5GXEQkSQeNz58dS01jK5Nc30Weg3YTXSnem10QBf18xAS5MdLAQYfuvmsptD6gwT5UJg3SAiS6YFmKxc5D8Yjmw4V8ASzKinJCnS9DX9zjapfZQfbIascF+UxoObosp7Tkx+XCEC2ulTqy3aNlEOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521070; c=relaxed/simple;
	bh=6GO1RWeSAL2AkF/OzEM5SCVC4XanY1WqHpcd7kPgYLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIleEcTM3sveRT2nuoD3/Khte9Bbqwkqb838cY4QQf8wVO3VItUWsTG+fMU0b1U5pRpn1Gbi6I5L7ObxfNbvoEV3r4RZ26/6Ff/PPUHmNpdPNzzfL3CT46CBOkcmevSgRv0tKeKx2zfV2AwjLQp2esZPoM20CKB+v7/10n5dyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYnwZhGq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6150be62be4so476848a12.0;
        Sat, 26 Jul 2025 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521067; x=1754125867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GO1RWeSAL2AkF/OzEM5SCVC4XanY1WqHpcd7kPgYLg=;
        b=iYnwZhGqy/XUEAVkEHjS1u8FSlJXYQHFBSx9sFg9bXoA1nJbwOMi7YZAPgrcK7ONFt
         q9n0MsKwPcxXJ3zwSfplwokPzQ3uYAjeShX5YV5D0tah/0JOlddMRY/d3JnlgSkioxkn
         tGjx25pSDLeE+K83saCyRqbzXCuuQ5cCkpWLorpX2ftH3vgZFTMC6jsGS+TfvjQi0uTW
         YczQS3/EVvFPSwWeniGjDWSqouGoERcM56eewe3UQYFw3dj7LzNZLtP0Lcb4YNw2o8SH
         uHRZ2OZyzWHm80ezlIgNJJdhJsuhWnf74kBP2kcED3a5q9UyqnAZqEOdMigUQXY2tX2C
         RIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521067; x=1754125867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GO1RWeSAL2AkF/OzEM5SCVC4XanY1WqHpcd7kPgYLg=;
        b=f8MUgaXKJOCf1RKxNm/2q/2CJXqOBumk/L9/Ec7TtbmFV6piaVSR9rElFaXq7b8sfQ
         GNAqpZuCueGoV20dTDgnYKt11f45Iz1yRdO3ijOD7L46bHaAa9XiVFHixZEYkZ+6y1PK
         mIvAzk4smO19u6gPSOi8f0S6vgxBTZzLLNUakmvmi7t4yN2pGTlJ2amEZwLnm1mI8l8H
         uJAheMQxCLRK6IyYRugch3g9mUgSttjx2d9L6dWyPK42uL6FFBQ/5Pm/Rbdkycm2/JK1
         Fk2WtwgIF7VfDCp/KvtlnL5pf2Sh0tiHgY4neBRk+W0iL/7JMxvQzn0RgoOciR+fvSnY
         dEGg==
X-Forwarded-Encrypted: i=1; AJvYcCU62OWruFgsGzq365HN7AVtS8USFbqWvBXo2qkBHC2Ia7QcSoJRBhvbTpayAkJGQ2QBp8LPXu35peDB7h7j@vger.kernel.org, AJvYcCVa21YGs3h5ZA2+IOEir/K3RFJt+rYvPBaB8S/hed0JPVZEFvC3afvRZjui/vI6Vr6vkpDtHXcn+zrjXi1FygU=@vger.kernel.org, AJvYcCW1E7EdJuhAw+7aITiPJmcQa8WLBfvBVovEetYSFIZBMlwMFNpG47zeapSCBgHpaNAAFMZiaFkkqX9E@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFToouKAN78JH6SyQJbBfOcUdvDDu4m8HO4U6mT9+ooYzt+rp
	R/XF1aG6PvjeWgxoZjltGBn/MImEslqd8K94P7VR5hM7fCiYzVDLv1sp
X-Gm-Gg: ASbGncv8ilTS219x9E8Txy5Hm+4uyWOCgr8u/amjeHlZdLbAr8ZGzYMrukmIAjuTBGC
	GOFrFWn2l9OE/2CxTbeq5jX9uDbr6SeFtWtbHx8LDok2AkghSyW3iMAwJz2EIwZVTI2v9nunuGz
	vGSrSCoDzqyV+t1Ig/LUIa0CT1jQ2klzF1s8HedNhzTdvpTvOZN+JY41De3UuYGVT15IjDq99XW
	Y/oDQR07XK4XbIALkB+VqCR8fkwIUJa2DP/LV1jKxrcttIs35wazqUV1TlQno3zXaZg+s10g8Em
	hcxcXe/SYhAZjIGwafFXSz5QNDGeEPmU2rLICqDYW63NybP86259gNl7I8r7c1xGCA66aDB9Ljh
	pdGZ1L1gXELHnJgGyIGTRu7dgQOXzgXWH
X-Google-Smtp-Source: AGHT+IGv2MIwdifVPt94hd01cMVCZ/nXPQZg5AldEwqF7PJ3XR8MYhxV2ZK0Wwfx500NxQf9kwVVOQ==
X-Received: by 2002:a05:6402:3509:b0:612:bfb2:386 with SMTP id 4fb4d7f45d1cf-614f1f2afe0mr5102471a12.28.1753521066681;
        Sat, 26 Jul 2025 02:11:06 -0700 (PDT)
Received: from foxbook (bfh67.neoplus.adsl.tpnet.pl. [83.28.45.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500a58aa6sm814588a12.27.2025.07.26.02.11.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 26 Jul 2025 02:11:06 -0700 (PDT)
Date: Sat, 26 Jul 2025 11:11:01 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Su Hui <suhui@nfschina.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] usb: xhci: print xhci->xhc_state when queue_command
 failed
Message-ID: <20250726111101.5928e289@foxbook>
In-Reply-To: <09d18144-ab12-4bbc-8b61-e0b334ef13bc@nfschina.com>
References: <20250725120329.2b6e3813@foxbook>
	<09d18144-ab12-4bbc-8b61-e0b334ef13bc@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2025 19:32:37 +0800, Su Hui wrote:
> On 2025/7/25 18:03, Micha=C5=82 Pecio wrote:
> >> Hmm, any chance you came across bugs that upstream should know about? =
=20
> Actually, this bug is specific to the 5.4 version of the kernel and a=20
> particular USB camera. I am working
> to resolve this issue. When the xhci_hcd is initialized, the driver sets=
=20
> xhc_state to "halted", but before
> the xhci_hcd calls xhci_start, the hub starts Initializing. Hub=20
> initialization failed due to xhc_state being
> halted. Perhaps this issue is caused by hardware...

Trying to queue commands before the chip is ready sounds like a SW bug.
5.4 is ancient (and EOL soon), newer releases may have this bug fixed.

