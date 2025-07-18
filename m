Return-Path: <linux-kernel+bounces-736925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B45B0A535
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539B7173A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBF7262E;
	Fri, 18 Jul 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="R6Wjrtq3"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454CD515
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845454; cv=none; b=adO5WfvtoijlCwZK0K+92KQxPxgmQ0LMHIm1bEjhSPLjQzur0kVFs9WDUnUmyFr6LLwRFgIgb4QVzfdte2C8imWHiTI/ztUDq0ZOwwtahGFZ4aZAcPUoTc3YNfiIl0xwjqh8KYfmTg905RPY5tXRqvSEtJMjBc6CmjYxub4N5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845454; c=relaxed/simple;
	bh=6ZpX7X0rmfiU2fjYz8EZJN4uBHvnNI+sQ4nf1kqeno4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrJALz+txUC0+CP/4seBjgmNCD/1aqullXPvz3cgDJXFesk94GOwTEgfl+9FOi+CJTJY6ASKcqddCM7RLjpdPa/Kfol2Z0jyQHYZeE+1AEi+x/YD2eMlui/CbKT2LURry+KRdOw6rLWDjFGVTO10195gOeq6JFfX1FYLdpbLdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=R6Wjrtq3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7dd8773f9d9so192565585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752845452; x=1753450252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JXQOBPOpeniDtauUd87p3H/3Obm46YXyflLj8QMwrY=;
        b=R6Wjrtq3172Qa0LQNR5CZ9UbfjgfB9OL8XBUtuLwiGn3TG+RvUszoBJ8F77k8WFZ1S
         RLuo9DfeiGblfLN+Kb1oNwlZYzbnLiCC0exJsqBV4oWAUeAmgKMdP11uOZDv3yTW1Hx4
         Rj3BVvIMhcQZcIKbuYmZB/MmtshqgRsYDFeWFB4OdrUVWL6j7d6sHOfThgU3nWNxQUu/
         +NLdkCxtszTsItKf7wwAR6EbuWRQWGeWw4Jxq5vMXhEtNDnBPY8Loac9HWBod1S3bhol
         OQ6BF62iv/xtj9Inrxb8YL4TiQoQyH88C7cZy3NnXqYi2g4KbxscXM7b17ryi1JQ6cZX
         nisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845452; x=1753450252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JXQOBPOpeniDtauUd87p3H/3Obm46YXyflLj8QMwrY=;
        b=Nhy/BOXzXL1fhN95uc9eMm2runI6gaxL5orB+4YoIOSP25z2dfWdkvn7lklNqbtaqG
         FDrBnSDIhefQYRs8qM64kMHAbSxQJMDXuiicb0Or68NoKA1j1OdeEX5ybZ0eBR8/DOEW
         IY+ewdXWbm7lkwqgeGHzLeVPg7XuUZUJLndASnNQ7Uuxw+wFtuYinuTOj0CajJK2YP/U
         YrOZZDLvtfvid26ecoxa9Wks4yt1kQQxe0iAPnbu+AcWn0GvDdnWmXT1dqdBcKX6YtVy
         Ncwf9UOXbJq4V1IAqkIHLL+BfDzQQ/oBXA2SFFMzt4QsYLtfx7x/Fln7zWIkTSrJat7r
         qJYA==
X-Forwarded-Encrypted: i=1; AJvYcCUWbY7iw7zSTXIvGKOWALANrRWnZk8pLyH7rD7u3GmNbNrAjVkg/410WwM8YvdJxIl94wC/uxm3BVQY2gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaiqOnSyePaTgvXT5azLRCx3C/SuwhDnsUGGCQ2Nw/f3Suz4d
	ArCATFA/9oeqBtmF9ZoA6JpTdvw71Xv+VEmRFhr+GNeKsUPsjMjuTK9CKcOWQP1MKg==
X-Gm-Gg: ASbGnculW4RkPAbREgYvDB3+gaULIJsi95V+cjKGij1VpF52G0tgRaZzEtOgbThUIys
	U1Xe0EXfC1VI71b8k/6WT9N2ct+bTGujLwjTR8hZ9yjqvIF0y9gLP4Ab0uOKFl/ujmlB0X5VsWX
	6k6svTRdYDbt4NwExp3TdvJdEtODmCSp+u8xEY356hm6FJ8LdTupLLuEcSyDyp78bER/4L3PLD5
	Zmf9X/wQslkX8gUf1HgIsc+Y47r1CUQ1wpgyLDOPzF2hgIS4WJbzJmU8YPYcJCiHVUsHnw8YFKK
	D280QYfv7UmeTDxOtwoP4fN/xHKNsiIQsClTvi4D8F2ZQreJU01coUpl6GM51dchCjv17vUoATy
	NHY3fzUiHYEmKl6ydtBw8Yzk=
X-Google-Smtp-Source: AGHT+IG9DCGlow8RUyjnM26wOo8WpDpnVWbEe+qr/BLBrMXZTf0h337i7WKbNfa0BnE1tuot1ezvig==
X-Received: by 2002:a05:620a:1a23:b0:7e3:3010:1fbe with SMTP id af79cd13be357-7e342a602acmr1393545385a.2.1752845451676;
        Fri, 18 Jul 2025 06:30:51 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::317e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b28eacsm84372285a.15.2025.07.18.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 06:30:51 -0700 (PDT)
Date: Fri, 18 Jul 2025 09:30:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: cen zhang <zzzccc427@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com, r33s3n6@gmail.com,
	linux-usb@vger.kernel.org, gality365@gmail.com
Subject: Re: [BUG] KASAN: slab-use-after-free Read in xhci_hub_control
Message-ID: <a78536aa-ca01-47e7-a1c5-6ac3113b0dd5@rowland.harvard.edu>
References: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>
 <8033fcb7-e97d-4b6d-a3fb-a9a49f8b69f2@rowland.harvard.edu>
 <CAFRLqsXoECbj6ffSvO9FhB2NAPE73j88DH7ES_e4vQYv1j4HeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFRLqsXoECbj6ffSvO9FhB2NAPE73j88DH7ES_e4vQYv1j4HeQ@mail.gmail.com>

On Fri, Jul 18, 2025 at 10:40:47AM +0800, cen zhang wrote:
> Hi Greg,
> 
> Thank you for your guidance.
> 
> I've collected more specific information about the test environment
> and the reproducer's behavior, which I believe provides a clearer
> picture of the issue.
> 
> The C reproducer is hardcoded to target /dev/bus/usb/002/001, which
> corresponds to the XHCI root hub on the USB 3.0 (5000M) bus.
> 
> Below is the cleaned-up version of the C reproducer used to trigger the issue:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <dirent.h>
> #include <errno.h>
> #include <sys/ioctl.h>
> #include <linux/usbdevice_fs.h>
> #include <linux/usb/ch9.h>
> 
> 
> int main(void)
> {
>     int fd = open("/dev/bus/usb/002/001", O_RDWR);
>     if (fd < 0) {
>         fprintf(stderr, "Could not find or open any USB hub device.
> Aborting.\n");
>         return EXIT_FAILURE;
>     }
>     printf("Successfully opened a hub device (fd=%d).\n", fd);
> 
>     struct usb_ctrlrequest ctrl;
>     struct usbdevfs_urb urb;
> 
>     memset(&ctrl, 0, sizeof(ctrl));
>     memset(&urb, 0, sizeof(urb));
> 
>     ctrl.bRequestType = USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_OTHER; // 0xa3
>     ctrl.bRequest = 0;
>     ctrl.wValue = 0;
>     ctrl.wIndex = 0x8001; // This unusual value is preserved as it is
> likely key to the bug
>     ctrl.wLength = 0;
> 
>     urb.type = USBDEVFS_URB_TYPE_CONTROL; // Value is 2
>     urb.endpoint = 0; // Control requests are always on endpoint 0
>     urb.buffer = &ctrl; // Point the URB's data buffer to our control request
>     urb.buffer_length = sizeof(ctrl); // The size of the control request data
> 
>     printf("Submitting control URB to the hub...\n");
> 
>     // Submit the URB via ioctl. The magic number 0x8038550a is
> USBDEVFS_SUBMITURB.
>     int ret = ioctl(fd, USBDEVFS_SUBMITURB, &urb);
>     if (ret < 0) {
>         perror("ioctl(USBDEVFS_SUBMITURB) failed");
>     } else {
>         printf("ioctl call succeeded.\n");
>     }
> 
>     close(fd);
>     return 0;
> }

That helps a lot.  It shows that there is indeed a bug in the xhci-hcd 
driver.  And yes, the peculiar wIndex value is the key.  The patch below 
ought to fix the bug.

Alan Stern


Index: usb-devel/drivers/usb/host/xhci-hub.c
===================================================================
--- usb-devel.orig/drivers/usb/host/xhci-hub.c
+++ usb-devel/drivers/usb/host/xhci-hub.c
@@ -1259,7 +1259,7 @@ int xhci_hub_control(struct usb_hcd *hcd
 		spin_unlock_irqrestore(&xhci->lock, flags);
 		return retval;
 	case GetPortStatus:
-		if (!portnum1 || portnum1 > max_ports)
+		if (!wIndex || wIndex > max_ports)
 			goto error;
 
 		wIndex--;


