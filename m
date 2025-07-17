Return-Path: <linux-kernel+bounces-735504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C6B0903B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD9E5A140D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BB2F8C21;
	Thu, 17 Jul 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HbD6O5/G"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628322F85E9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765008; cv=none; b=UZiXyh2yg6kzJeH+3reI2EBWyTH4V3X8UAJxLwcHFUiCBl4Lu3ElR4xOU4oJTjyc2SA98w6iBcTUWOd7iZ9TrsMgwHZ+j6+lQsulbjoaidtz9JPgn5ev2Tlsy1hSdWqB/m8Y5vehgfCwB5VxCZcn3B9eiwouYieH7tGoFoBROu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765008; c=relaxed/simple;
	bh=2ygljk2Uqk1He0z4HYejFMdZFckkiVsTIKFbHka5iA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxbINvQKLw4Wjdg+fgoIVjwEQL53mOy+LRcDAwItKA7b/RNOp1YJnn02LngrelG8w0A6G/1SWCnYFtNE3n7jGfIyICdIQRrEZ25RQ+SlAL0ZFmUy+WyzQ+qSREDJyliouiXI1aa8wSNvVOgv8kFZUx6sWcBNlaKNbTAiqYM+cNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HbD6O5/G; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fafdd322d3so11402236d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752765005; x=1753369805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMkrTXBzfaq3rWiLym1Qv+vgbExX2qt7dFfmHvP61uQ=;
        b=HbD6O5/GK/yQdKNScNVGT8VSfW2UvgRXN/9tFJa4WflPMhUbIZyQE5RNQzJy5gLRVi
         7SgR/9HJCpM3a7ZtO2TTba2A+yohyndwRvm6yRrpiuMms2GDSgwRQcFQXZdjbfBj9Jt2
         mBXMb+O5E1CwT4eW0sLarThbER95kEDSUGgC9GX0LvQigLepC9VpnFEyBBGbUuv4n3+G
         U2MjNIj/2iqp7F8Vl2nS9jOeLk97Gk/rBDmP9BO0x6+BcwPmf+2STvB8F3+I1yZ9ClBp
         VNEWYFSLR+iWo/LHFr0nryOFCSiKFs9Q10o+uq0iGG1prK0mnwyNF+p+nZQy8Ij1r9Oh
         JtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765005; x=1753369805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMkrTXBzfaq3rWiLym1Qv+vgbExX2qt7dFfmHvP61uQ=;
        b=maWBbIvJsI1y4EhjOOBYjQtP3oc4ZZVJ7iAVPnqEjJX2Wx1r6qMZnOC+kbkPm20g4f
         bfPfPWjL5OXNOTIjLBc+kPE5ZbTj4oRi8R3nxGf8TxLWTSRwJHMCbBr1ZXEzQl3iLxaD
         h8sQ8wqcIxTnacqXQEA+wrxpWUfXi9NuOrZF96dARAQ8QsxFkzfLi+qD/DxRDRs2Ru5Z
         +RGpYe8M/quN+14vM+kPOapXkpYlXyZ3//S5G5vpw8EM2gWdm5BnOeG5dkl4rN2gltMa
         eojpkjpd5enK5q8L+nsCyPHrapxpSG22KLyl7DMxJzbrzBmWf+6Nl3gOjeonY7rH/bmA
         xf1w==
X-Forwarded-Encrypted: i=1; AJvYcCXvSQrgHrnTccdjYfYV796ynfIpgHBp3/vZo52MBe+06I4dNU+Xj1xYZ7go0LFYnbMsWX/F0GJmD2iiPCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43gFysRbmVDCesh4SDnoNSd+H/L55ljhoPYXuUib4j0e4BLKl
	m9ITlUMomnXgDGJzqovyXDd2hJBSXh+cGf+U5OyCSaK1K3DxHHZhIJl9XtjIXrydJA==
X-Gm-Gg: ASbGncuIonUzrDx40RuddIAgAgNA6wqerJ8ptqjBeJzVrRrqUsIwBZ7PECTuKAI8PYg
	rRXCoHqyR840nPkhgLFrMKxK4RMnXmJwaKbwhCvY/UXQ8QWnBKhW2+IlXi9iFFIJJJwFsPMEsYu
	R/wWMdu913KlJCbfn2AKsvoX1fm/abprH1Q2VDRhyZbBinX76ReqQn2Uxvzx/lhvd3oJpDjigET
	531KdrOBNS76Y/NrZwPXj9RfCIyPFc2xnIoKw45WoXjQz2Tozn0QpAkWHcZy41ch6M92xLkuR1P
	8RUFBxuFUXNKIE6FRLfMF7hqeK4iSXyuJ5CXfpOcObRh6ux3BMZ+ZFOtOmVCFWntbxC+ivQepAi
	19AeeCJQQWyg+0MHti8aZITFJ+czRXFmzTSXcEmyG
X-Google-Smtp-Source: AGHT+IFHw7EDM0Ve8emqO8zAANy76pLvuQMaMZ2gTShPCrmHYOtitdMLZSMCt19Kay54OFuds4ESoA==
X-Received: by 2002:a05:6214:3bc2:b0:6ff:16da:af20 with SMTP id 6a1803df08f44-704f6a57203mr93992966d6.14.1752765004966;
        Thu, 17 Jul 2025 08:10:04 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e45d2sm85876696d6.52.2025.07.17.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:10:04 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:10:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>,
	jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
Message-ID: <15723551-960b-4257-bfbd-073e136deaa2@rowland.harvard.edu>
References: <8bec1698-5008-428f-8e71-ec002def0c54@rowland.harvard.edu>
 <6876b0ec.a70a0220.693ce.0019.GAE@google.com>
 <78c3fb66-c30f-4c64-a499-61c1665186a8@rowland.harvard.edu>
 <d21dcce3-88ba-416c-9d18-ea47855c48fc@rowland.harvard.edu>
 <zakga5qqql6zyat6wbnntm6tvcmhlhmjt5ecz6nm5hpc7z2iw7@mcpmrg7r4qlt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zakga5qqql6zyat6wbnntm6tvcmhlhmjt5ecz6nm5hpc7z2iw7@mcpmrg7r4qlt>

On Thu, Jul 17, 2025 at 01:48:41PM +0200, Benjamin Tissoires wrote:
> Hi Alan,
> 
> On Jul 16 2025, Alan Stern wrote:
> > > Benjamin:
> > > 
> > > Clearly there's going to be trouble when you try to convert a signed 
> > > 32-bit value to a 0-bit number!
> > > 
> > > My impression is that hid_parser_global() should reject Report Size or 
> > > Report Count items with a value of 0.  Such fields would be meaningless 
> > > in any case.  The routine checks for values that are too large, but not 
> > > for values that are too small.
> > > 
> > > Does this look like the right approach?

...

> > This patch didn't work; the error message never showed up in the kernel 
> > log.  Nevertheless, hidinput_change_resolution_multipliers() tried to 
> > create an output report with a field having size 0.
> > 
> > How can this to happen without hid_scan_report() or hid_open_report() 
> > running?  It shouldn't be possible to use a report before it has been 
> > checked for validity.
> 
> It's just that the provided report descriptor was never setting a report
> size or a report count. This way, we are stuck with the default value
> from kzalloc: 0.
> 
> Basically, if your report descriptor is as simple as:
> Usage Page (Generic Desktop)
> Usage (X)
> Usage (Y)
> Report Count (2)
> Input (Data,Var,Rel)
> 
> Then we would trigger this bug: "report Size" is never set and is thus 0.
> 
> Your patch is good though, as it is probably a good thing to prevent a
> report size/count to be 0. But it's not addressing the issue here
> because the only time we can check for those values is when we receive
> an Input/Feature/Output value (or ranges), so in hid_add_field().

Of course!  Thanks for the pointer.  Let's try it out.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git c2ca42f190b6

Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -313,7 +313,14 @@ static int hid_add_field(struct hid_pars
 	}
 
 	offset = report->size;
-	report->size += parser->global.report_size * parser->global.report_count;
+	i = parser->global.report_size * parser->global.report_count;
+	if (i == 0) {
+		dbg_hid("invalid field size/count 0x%x 0x%x\n",
+			parser->global.report_size,
+			parser->global.report_count);
+		return -1;
+	}
+	report->size += i;
 
 	if (parser->device->ll_driver->max_buffer_size)
 		max_buffer_size = parser->device->ll_driver->max_buffer_size;
@@ -464,7 +471,8 @@ static int hid_parser_global(struct hid_
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
 		parser->global.report_size = item_udata(item);
-		if (parser->global.report_size > 256) {
+		if (parser->global.report_size > 256 ||
+				parser->global.report_size == 0) {
 			hid_err(parser->device, "invalid report_size %d\n",
 					parser->global.report_size);
 			return -1;
@@ -473,7 +481,8 @@ static int hid_parser_global(struct hid_
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_COUNT:
 		parser->global.report_count = item_udata(item);
-		if (parser->global.report_count > HID_MAX_USAGES) {
+		if (parser->global.report_count > HID_MAX_USAGES ||
+				parser->global.report_count == 0) {
 			hid_err(parser->device, "invalid report_count %d\n",
 					parser->global.report_count);
 			return -1;



