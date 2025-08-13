Return-Path: <linux-kernel+bounces-766330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CC4B24543
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA78560826
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1092F068A;
	Wed, 13 Aug 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YzyT0hZL"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109927280E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076963; cv=none; b=Z5y5astVVV5d5QQYHdA/Ep+2fnARoBr2PDV1y/fzhMeEwdkGh86fEszXI4ICsVRNwgLHdEf6MZyExA95xSP35iN9Glm7YIhY4/JH4HeSeaan9dfKWhFcoODYZZZS7B5HoUdbYtJV+6hLXTVM0ckC3UO2vZ8KOGIRK0Lhft1gXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076963; c=relaxed/simple;
	bh=u9hYS1NsBTcDS5+qLmOVwr5AfnwW8138WluVpJRpuQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=LK2AUUoooz0tdBbF4Q6YINhfdpyxOQRXvZaIiuWl0qn1ikPxl7JU2DNNBXaWpXR2vH4ehVDGdaOzgZNSA5880Y4gOwfvQyfEvkZ5fmqomBG36V/QDAOjptmn88tBN4mZG0TaFArGGQVQkQVKW21dvA8rF20rxpiCS4QYqVcvMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YzyT0hZL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250813092238epoutp011131ba21a27ae899117482b62636ef05~bSTHbF4bm1801718017epoutp01Z
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:22:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250813092238epoutp011131ba21a27ae899117482b62636ef05~bSTHbF4bm1801718017epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755076958;
	bh=W6icd7hQZI7BY+JmhQpBzL6/i6Ke2KB+v4j5CI2+IMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YzyT0hZL/juSBAqi9oE41JsEuLcUu8wZksp5LdhxR4gBXnZE0buFDnJvICau9rQbn
	 1X3VWERqFgS0OhsVmbtUC7kwqoJH3VnB7rMNLBZLZPf6XL7mQrl8PQX27KY7ruuM1f
	 rwRAFN6c5vVL4wyszH5yKUeoQy55GDg9xh92cD7o=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20250813092238epcas1p105d9ae83f25a41c6bea0f1f9c4b7130b~bSTHPMbtA1796117961epcas1p1T;
	Wed, 13 Aug 2025 09:22:38 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.248]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c22vx6xb8z2SSKh; Wed, 13 Aug
	2025 09:22:37 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250813092237epcas1p19f0abc75fc57d052b1ca71cc6a5bb585~bSTGt3Ygx0970409704epcas1p1i;
	Wed, 13 Aug 2025 09:22:37 +0000 (GMT)
Received: from minbellkim-500TGA-500SGA (unknown [10.252.69.135]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250813092237epsmtip1030f4c63b3f827a756f5e202dbb81244~bSTGr2oaA1254612546epsmtip12;
	Wed, 13 Aug 2025 09:22:37 +0000 (GMT)
Date: Wed, 13 Aug 2025 18:22:34 +0900
From: Minjong Kim <minbell.kim@samsung.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: hid-ntrig: fix unable to handle page fault in
 ntrig_report_version()
Message-ID: <20250813092234.ja5qfpvkxocfnchd@minbellkim-500TGA-500SGA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <elszhqc5knv2o4mvq2frul6vglqxsdyrjepzgmda45lmrh4ylp@qvdvsgumuigx>
X-CMS-MailID: 20250813092237epcas1p19f0abc75fc57d052b1ca71cc6a5bb585
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----x7tjPybBA_a1iX0jQ-dCmPjBp0yMxIO3RfoDNzdmyopSira8=_230179_"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250717061154epcas1p329022ab54ed143d2a8d5b3f8b7554b38
References: <CGME20250717061154epcas1p329022ab54ed143d2a8d5b3f8b7554b38@epcas1p3.samsung.com>
	<20250717-hid-ntrig-page-fault-fix-v1-1-96fa145a137f@samsung.com>
	<rqo85n88-82s2-30s6-qn80-r4r943p4q59o@xreary.bet>
	<20250813051751.z6vxd6tvrfelmxou@minbellkim-500TGA-500SGA>
	<elszhqc5knv2o4mvq2frul6vglqxsdyrjepzgmda45lmrh4ylp@qvdvsgumuigx>

------x7tjPybBA_a1iX0jQ-dCmPjBp0yMxIO3RfoDNzdmyopSira8=_230179_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Aug 13, 2025 at 10:39:37AM +0200, Benjamin Tissoires wrote:
> On Aug 13 2025, Minjong Kim wrote:
> > 
> > From 75e52defd4b2fd138285c5ad953942e2e6cf2fbb Mon Sep 17 00:00:00 2001
> > From: Minjong Kim <minbell.kim@samsung.com>
> > Date: Thu, 17 Jul 2025 14:37:47 +0900
> > Subject: [PATCH v2] HID: hid-ntrig: fix unable to handle page fault in
> >  ntrig_report_version()
> > 
> > in ntrig_report_version(), hdev parameter passed from hid_probe().
> > sending descriptor to /dev/uhid can make hdev->dev.parent->parent to null
> > if hdev->dev.parent->parent is null, usb_dev has
> > invalid address(0xffffffffffffff58) that hid_to_usb_dev(hdev) returned
> > when usb_rcvctrlpipe() use usb_dev,it trigger
> > page fault error for address(0xffffffffffffff58)
> > 
> > add null check logic to ntrig_report_version()
> > before calling hid_to_usb_dev()
> > 
> > Signed-off-by: Minjong Kim <minbell.kim@samsung.com>
> > ---
> >  drivers/hid/hid-ntrig.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> > index 2738ce947434..fa948d9e236c 100644
> > --- a/drivers/hid/hid-ntrig.c
> > +++ b/drivers/hid/hid-ntrig.c
> > @@ -144,6 +144,9 @@ static void ntrig_report_version(struct hid_device *hdev)
> >  	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
> >  	unsigned char *data = kmalloc(8, GFP_KERNEL);
> > 
> > +	if (!hdev->dev.parent->parent)
> 
> Why simply not use if(!hid_is_usb(hdev)) instead?
> 
> Cheers,
> Benjamin
>

From 61818c85614ad40beab53cee421272814576836d Mon Sep 17 00:00:00 2001
From: Minjong Kim <minbell.kim@samsung.com>
Date: Thu, 17 Jul 2025 14:37:47 +0900
Subject: [PATCH v3] HID: hid-ntrig: fix unable to handle page fault in
 ntrig_report_version()

in ntrig_report_version(), hdev parameter passed from hid_probe().
sending descriptor to /dev/uhid can make hdev->dev.parent->parent to null
if hdev->dev.parent->parent is null, usb_dev has
invalid address(0xffffffffffffff58) that hid_to_usb_dev(hdev) returned
when usb_rcvctrlpipe() use usb_dev,it trigger
page fault error for address(0xffffffffffffff58)

add null check logic to ntrig_report_version()
before calling hid_to_usb_dev()

Signed-off-by: Minjong Kim <minbell.kim@samsung.com>
---
 drivers/hid/hid-ntrig.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 2738ce947434..0f76e241e0af 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -144,6 +144,9 @@ static void ntrig_report_version(struct hid_device *hdev)
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	unsigned char *data = kmalloc(8, GFP_KERNEL);
 
+	if (!hid_is_usb(hdev))
+		return;
+
 	if (!data)
 		goto err_free;
 
-- 
2.34.1


I checked that crashes didn't occuered this patch
then, I'm just wondering why it is effective?
could you explain me about this?

Best regards,

------x7tjPybBA_a1iX0jQ-dCmPjBp0yMxIO3RfoDNzdmyopSira8=_230179_
Content-Type: text/plain; charset="utf-8"


------x7tjPybBA_a1iX0jQ-dCmPjBp0yMxIO3RfoDNzdmyopSira8=_230179_--

