Return-Path: <linux-kernel+bounces-724032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F2AFEDBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB733BCE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39A2E8E08;
	Wed,  9 Jul 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="QkH9vf+5"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027292E7F00
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074900; cv=none; b=jzmmkCFiiNOn6gIR1cznkOr3b/E9DmSHz4EeEo3TQ3UitK2YonE1vO2sy8ginOphmbgSjnT+P8/9Mglb/NlxT8w5xiRaB4GI1XwAucJY45/HQfCp1MdDdouaZp/B3+XumdkUxlGcQY95YqdxGO7SeFX7ak5h4s/daQNYc5yYLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074900; c=relaxed/simple;
	bh=GcZ28gAnpCwWyj9Z1Aa2tA615DhzFzhtYW1BhESPJWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD3bgpD3CdnoIXsHLW5/CI0vAMzKNetCLuSi/ZGAhFzye2DNjmJLwHn1Pq0AD46KUlotIwxRe8ZNI//pCE+hsc20kpe728OsYSSyCOIk5IfcVg2BDzl+k/sNYugsju8IvrilU8PJhmxr57fJBX9AchnR1difu0m6EnBzcPKlg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=QkH9vf+5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fabb948e5aso312006d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752074896; x=1752679696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wj2WD7wEx17j4YeiMtaoaMm0CGv0tCDxMgy3ho+uEW8=;
        b=QkH9vf+55L7INPEO1opmWNaj7tcVCw34jrCObkk12VstauOXxDxrI36GPryyBCK9aq
         Z0nuz/4758IsZwSyuZayyKUM/B4Or51PHhWKvNdzAlMAd6n4CqtpgOvosZ7DwyrL1Fa1
         cdXmaf6F5zi70q6Iq5kcWX3TseeVyYdsVs89dE2PAW2Pk6WWUymbPHVWBzvM7nw/60UT
         6fp3TUqMWgDocPaJeTooOGumo6V/r4PLMfUPGVyNltvakkNma0L/mSaN75ViC3s31Icj
         gpo/0xY7P5TOb2JxdVLdqai6AR97R8lAv6Tu7+0zNx/6vRvo4gkO2bORTBDmCeC6DqE2
         sTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074896; x=1752679696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj2WD7wEx17j4YeiMtaoaMm0CGv0tCDxMgy3ho+uEW8=;
        b=HLbKS47J8vtldvmVcLsTv9dFPGuOm07JLmYy9t0JvoqIRbmprA6ApH89dy1rtKkq8t
         zRkYKvP6WjTdcVhRUwDYRj7ozzFBAG3Xyex4wzqsBGxGuaPpWmIeRwy0b8OIjGQivjlI
         pDY/tht0jcfrG+AJEHbVqo6T+7sJNoC0BWMIZ6gTfHliw52ut8TPwQbGIJhQ/KlzVLZP
         sQAYmUOx6l5Jw9YyiYbdDVCEhSKu15Mxg5Kczgkw7i9hLPEYAByF9/Ij4rS39XM3tYPi
         oRXfbri5pxxAbr5ZRUvwFROgK+pH0Rbivqmm7JdqT3Eocb7ZN0AWzyQZJkLbmuDgsig6
         pA6w==
X-Forwarded-Encrypted: i=1; AJvYcCXuZeNtwhVVkXV8X2rYlZtESyx0n0o9VTVui6yCfSvNTzd2pScSJNKIFcWjYpC9sxH3DNATaqsulP3XC5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOT561ONjhoHuke1AMLVZBXmCATVXUMzkc6sghbwjzNTbL+HmK
	+IFitjSgudjekKb7Igv69pVAh665ncemrf4PnW0mNYfr9VzFyqemkTUemOwXbBecIg==
X-Gm-Gg: ASbGncv4dFkTrN/oiZc6lx1TeUTeSGbHct/nTobNJnkWLxTu62jmlJz82W++2GmuQyQ
	bRGj1omb5WRaWuE/ToZmPonTFQtW18DVNO2daPLxOqtXJoPDn0j4TxYkPkSJ0zZZtp1UdEMrE0l
	HVboAFZv3vhm13MBnk1/p7d04W3ZbiN/n37GXXAI5jtBHhXSh5FRiFLp5+ksVcYcXzHURZiVOaV
	IuiyNzD2UmzfIy9Bg1vw4G56whrEzmRSyzjP7URqt5D3FTm3AmJswdp7sjN0sj5HrwxPZJLHVAx
	iECqFul/5YANm08a7N5I3K5mAJfl8RO8SIc8Nro9eejA44Qk/nESmcoOz/0kOInCYWtBSr1XImw
	SyieL
X-Google-Smtp-Source: AGHT+IFN+tN8BWann1ct7Od+YPRK2S5cl81IkL4UL283JRTfnUO9ypZv9OBjSCqdxq0z2cHZp8MCBg==
X-Received: by 2002:ad4:5dec:0:b0:702:d6e2:5bbe with SMTP id 6a1803df08f44-7048b9438b0mr38902606d6.4.1752074895587;
        Wed, 09 Jul 2025 08:28:15 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc771esm92910336d6.6.2025.07.09.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:28:15 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:28:13 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 mon_copy_to_buff
Message-ID: <5644bdbc-8449-407c-8e0c-e725e10a40f1@rowland.harvard.edu>
References: <5de04492-01d3-4b2c-b3f4-8c2237dfed6a@rowland.harvard.edu>
 <686c14c0.a00a0220.6237c.0000.GAE@google.com>
 <72fea4f2-40d7-4f9f-a08d-b1ada781256e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72fea4f2-40d7-4f9f-a08d-b1ada781256e@rowland.harvard.edu>

Here's Benjamin Tissoires's patch.  Let's see if it really fixes the 
problem.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ d7b8f8e20813

The low level transport driver expects the first byte to be the report
ID, even when the report ID is not use (in which case they just shift
the buffer).

However, __hid_request() whas not offsetting the buffer it used by one
in this case, meaning that the raw_request() callback emitted by the
transport driver would be stripped of the first byte.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Closes: https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/
Reported-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8258d5439c49d4c35f43
Fixes: 4fa5a7f76cc7 ("HID: core: implement generic .request()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1a231dd9e4bc83202f2cbcd8b3a21e8c82b9deec..320887c365f7a36f7376556ffd19f99e52b7d732 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1976,7 +1976,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 int __hid_request(struct hid_device *hid, struct hid_report *report,
 		enum hid_class_request reqtype)
 {
-	char *buf;
+	char *buf, *data_buf;
 	int ret;
 	u32 len;
 
@@ -1984,10 +1984,17 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 	if (!buf)
 		return -ENOMEM;
 
+	data_buf = buf;
 	len = hid_report_len(report);
 
+	if (report->id == 0) {
+		/* reserve the first byte for the report ID */
+		data_buf++;
+		len++;
+	}
+
 	if (reqtype == HID_REQ_SET_REPORT)
-		hid_output_report(report, buf);
+		hid_output_report(report, data_buf);
 
 	ret = hid->ll_driver->raw_request(hid, report->id, buf, len,
 					  report->type, reqtype);

-- 
2.49.0

