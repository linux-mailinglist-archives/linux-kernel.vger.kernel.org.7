Return-Path: <linux-kernel+bounces-862936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A3BF6916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E194465B26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBFE33291F;
	Tue, 21 Oct 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI8j0LnT"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A65332ED9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051296; cv=none; b=RBAbIYB4qI8Tpsqtyzeak6tHbHelJ8lwiFQ0zQiIs1E/gUcnko1+/GIs1laxvgCGyJvdONhSL/odcWetKNiSz86ptzHRk7gLnSayknr1xV5jUwlWUblBoDR+hyGeOSiyHWUZlLuY2VYNiMdZIabnAgRGNZPJg5slNdw+NjQbAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051296; c=relaxed/simple;
	bh=HnKWHFVv0AYcRhz/eFjf/zIYKDTs92rkesrrKB0d0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcI1zWIHD2A5b6m2RSacWFS/VSz5h0vjPtxmo032kU41zqHt71aVXdK86tRaf54v00StQ6YAuHmzNnlX9ACf5xKoTkl2sg4cr0cSYrhrqNSIzaiIH9+HyT1vcDmhTBXAC68R42eyF5OKAemoKYjd/p9uZLZpfWIqSq1cE7y2/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI8j0LnT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1070267166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051293; x=1761656093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhiJSrqs+stuku6ihyFAqxGodPlxM4DaxRFdGGu9usI=;
        b=DI8j0LnTm8lMnAFHXmyK0O20Lmd8vGgG9S6nDRb/0TEysVjG8I3MJMOTZyGNLi8ns0
         3xmvix9ddx9dyEdr+82N/1EhGW6ojr9NxX0drfI/9NNzOsHVtvcGOcEhJmqOq4IBLuoj
         qTfqnw8v0up0crVxngKAK2CkpQdes7a4kWByTLItG3Nwx+7ZZ9pG83cmFlhYHan0ybtC
         sPsnKqH59epi8670g/PsnxDxxMabJlARpKQJKU4KeZFTwowU7aP5lkdcL+eAT/2k5zuQ
         Z0mTyQujEbS7Zrxc1ame+h8sizGiP8crS7jHIbLn1PvWEGsDEy/VBpO0h/nBW1PpQgBx
         JM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051293; x=1761656093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhiJSrqs+stuku6ihyFAqxGodPlxM4DaxRFdGGu9usI=;
        b=NZzzR48PxAygw70u/5r7zMpZWoCwoPdMg379VLlMzPtgpLA6N9aKsx5kvB/ziaoeY1
         pHlP1MAwAjCe9fA4ihCe3ozVoGTrL9iy8eLImTE+KL/rO7MgKEDr+tYzx8CjWLu4Hhoa
         uyQE5laY/xBB85z95xcgxIG1ZME5LBb2INyExJq+b54HgD7M0v/GksGYlaLWSacJjzot
         NqCwcj1pPV2xW6RpQssi694VSOVFSwUaPPLvFjUkLz5jH7/fat9Qmx4iqH5M7O/kRBCb
         akBjg3o1JNVb8cRpRjqQ2KqIypUbHjdrJm2Rit6m7UwGfnx9IQxwLjpJFEC3WzQ2KiAV
         HAIg==
X-Forwarded-Encrypted: i=1; AJvYcCW5krrcf4Y28vs3L6XoGU9qyfHMZEika/hJme4GT0evxfrvOyyQNMZNSnwEirPWMwpRpxKIeoYKKGpElc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7yahWfp+QnfA8JxpSPT9fBMVZqKtyNI5kNHOVBRnb9czRSUn
	yr87w7d0ICWatU4fiNSj31tRxAfm8v3OW6moE7XmVrGfFuK25x5X/aB9
X-Gm-Gg: ASbGncueUE3LDOP9jPlsyVzKf8SLLHMT74KTSWwl99PI+6AN1I9BvBEfwDh5UKgUebv
	CFA6Kq/eJpUp3nlXyNLf77ckATy3HDb+nbkfMwklP+5u21vCUmPX4q3ESTlgFGG/td0yWhHZB/x
	zfJseAL+zommmt+6pOOoiMAw4VUrlhtREEwe1xBAjzCJ0PsEUS/VsVYONwyTo87z9WIJEFv8E+O
	pJvpmb86Anxsk6V1ffiPaH0nTSVXmOTJ6hykBvF0ca/LHY0ixeP6TEk6DXJZZiFyELixeyNFGEy
	RpR+ZamFfn5a3Vlln382xbg4Z1+PFkgGd6AULteNYNQOP1uZYMTtobAxj5nBYMaY7CbQ3xbZM2v
	icemBC3YR84qH563PLRip2CL20fSjfAweHjoLGUQsLTa0O+r8tQ4OnlKNE503RJIVprXkxYHFVy
	7LBElK1kVq5Pi9
X-Google-Smtp-Source: AGHT+IED4rIk2aydZFVCa0pw6CF5ZaOerW1OexhJSr/S8sqp1U7+sBg1/U17BT8+Mtilu1EqrR7DUw==
X-Received: by 2002:a17:907:c09:b0:b3d:5088:213d with SMTP id a640c23a62f3a-b6474b36a25mr1655258266b.42.1761051292676;
        Tue, 21 Oct 2025 05:54:52 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b65ebc48eedsm1065996066b.79.2025.10.21.05.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:54:52 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: chris.feng@mediatek.com
Cc: chetan.kumar@mediatek.com,
	hua.yang@mediatek.com,
	len.brown@intel.com,
	liang.lu@mediatek.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@ucw.cz,
	rafael@kernel.org,
	stable@kernel.org,
	ting.wang@mediatek.com,
	"regressions" <regressions@lists.linux.dev>,
	"DellClientKernel" <Dell.Client.Kernel@dell.com>,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: [REGRESSION][BISECTED] "Wakeup event detected during hibernation" on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup events during hibernation")
Date: Tue, 21 Oct 2025 15:54:46 +0300
Message-ID: <20251021125446.4384-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20231213083251.186935-1-chris.feng@mediatek.com>
References: <20231213083251.186935-1-chris.feng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chris Feng <chris.feng@mediatek.com>:
> Wakeup events that occur in the hibernation process's
> hibernation_platform_enter() cannot wake up the system. Although the
> current hibernation framework will execute part of the recovery process
> after a wakeup event occurs, it ultimately performs a shutdown operation
> because the system does not check the return value of
> hibernation_platform_enter(). In short, if a wakeup event occurs before
> putting the system into the final low-power state, it will be missed.
> 
> To solve this problem, check the return value of
> hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY (indicate
> the occurrence of a wakeup event), execute the hibernation recovery
> process, discard the previously saved image, and ultimately return to the
> working state.

#regzbot introduced: 0c4cae1bc00d31c78858c184ede351baea232bdb

Hibernation doesn't work on my laptop.

My laptop is Dell Precision 7780.

Hibernation starts, then aborts. dmesg contains:

[   28.283320] PM: hibernation: Wakeup event detected during hibernation, rolling back.

I did bisect. The bug reproduces starting with 0c4cae1bc00d.

The bug still reproduces on v6.18-rc2.

Note: there is another problem with PM on my laptop, which is tracked here:
https://lore.kernel.org/all/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/ .

So I always revert 1796f808e4bb in my kernels.

But this doesn't prevent this hibernation bug.

In other words, this hibernation bug still happens on v6.18-rc2 even
with 1796f808e4bb reverted.

Steps to reproduce:
1. Power off laptop, then power on
2. Hibernate ("sudo systemctl hibernate")

Hibernate will not work.

Note that to reproduce the bug you need power off laptop, and then power on
it in step 1. Merely reboot doesn't cause bug. I. e. reproducibilty
depends on whether last boot was reboot or cold power on.

Also: suspend works normally (assuming I reverted 1796f808e4bb), but hibernate
doesn't.

This is "dmesg --level=debug+" on v6.18-rc2-with-1796f808e4bb-reverted:

https://zerobin.net/?0459f6411446622d#8i0Ifo6o68By3+UlYUr2t2KL7YLXsKEXrkfszpE77Rw=

This is config of this kernel:

https://zerobin.net/?04e89ceab8284c1d#9bpaZKqVXFSaeav/WW6GOCwD4i3SozzQ8pBEJ6LWwVM=

-- 
Askar Safin

