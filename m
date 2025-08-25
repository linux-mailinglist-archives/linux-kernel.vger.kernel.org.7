Return-Path: <linux-kernel+bounces-783882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAFB333D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998213AEF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A022577C;
	Mon, 25 Aug 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HZv21MBT"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA57081C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087310; cv=none; b=bt3AHao4m46ieUhX/TnX7fCQENkm+jb3Fcwzgy9t4OA8Hkm/W8dI38Fv853E1xFTvE67xHwC6TXX7TXgnGv0KyeWhzl/lu+yyDSYFNmVYm8sz62ZI1osQGk4fhpbEHcDaWrAjTbMKQ3Issc3tqYS95Z5rA6EIKMhZd2gfUKMPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087310; c=relaxed/simple;
	bh=wIGH0m9FtHFoD1tG6AB6wD3rrqQLE7xeks1HyczeahU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbj1MzYntkRz9jWCZwxXE/cLJ9S8BFrkBdK7dmpFeAoY2o0AyWECVar5wy+7CHomksMAn/5WR9s0pn91gIYiXDRuw/M9qX1mTAhuSwwN2g6Tb88P4BpGDxbUX8pg4Nx3fOqYEcA4YhrNkOiPcgNrn4SYNEmdUZiYb9fCf0xj000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HZv21MBT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e9530e59512so964902276.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756087308; x=1756692108; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPoitRQ/IXYB+BKPn84zctYfWeLgkj6/m9I8qp2PJXo=;
        b=HZv21MBTsj6l0pHaEdgSCX6vQhqg+9hwxrx8S28ICUZ6c8K6TWqQ1k9Cy2L9uavfsL
         79o/II/Qmq6MCEBGhwHBfLDdKwfnJNNuN2OiV9td7a0BdqwQuj54ZPut17GT2mbL6jWR
         EffQPOsJr3DKi+Tplk9Lj5RMEh658V0RsqySjGOmIsbvyxEyOJNCogY/qfB42nqWVXPx
         b9YHLScWiaB0s5rs43AWkJu0SsC0QBYHZ/6nUrrxpEo2pOQ9QCECEvZTqrHCOisAcSD4
         3+wvRLZKm+eYMDL/HJxdoOhjyCOldGwcxr6YRkNShVPxenOaO0v1L1FCyhOyuzAkJlu4
         zQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756087308; x=1756692108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPoitRQ/IXYB+BKPn84zctYfWeLgkj6/m9I8qp2PJXo=;
        b=bwiYhhLAxbIjLgmLFU5dd8YqoEg+I9cM2k++QEJFE3bdegT0WwyUs1lbtjw6Mo3nvp
         Le7bz2yCQ3p5omy+98EcUS/OTntkse/oT6OWfog/GQCn+Izg3uFcMDlJ9tU+q3Loqi/i
         BZVAF2z9DUG/8R3WpI88IYyIrpx1c+1cfJRjsQFhYaVlV39Ba0cncFzKWOc9V31kCCl9
         GtNfXs+WFhBm9kCg5oXAXbkVQIOuiIfAzTynFa4aWeoV6q76N5XkBFyHAuyiew3EEWpM
         GJkZat2O9MuM00rE4znjAq4Jcnlg2GCk5HP/PSD1GQuxwiSu5a8PEipZrlpD5SqmDmjv
         jacQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXCYM+X0vndC2BBV+PE1BSH7j/bj8I+kbJiTflZkK9CXWouJvT0gPtUpt46DcOcrUtJAiLsAu9qyYHAgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ioI9AiamRelnGtP97oebyf62azi2AjKKp+Kc9tyzgy2ljQwh
	Os1C8DuT6/WL25PKvy1xww1gfyBcDtfpsRZfh2xzeN93EKG1hPVa+Vn+bJ45NthESg==
X-Gm-Gg: ASbGncv/G2jjoAL1niSPw4If4EUB5HlNqcpdpCwHrjZltxBPu85POfB+WDPjBpO2krK
	TvaZyt5DPfZ+9ItPmq3ngT1XKz7W40TchVlLWRndXJ9568TBkuA72LA3Q9AsgDmptnaL785tvYi
	rqtajwuPM08gquwougViBgFfDCRQ3Kd9fS4849cATP717D2LQju7iOnpJzHkX3+aKc+kyvgEix1
	+yb8GgvDfSGLxVmAsODsBZToQRAZ1PcRD7T9H+OTu7iJcG+JMFW4PNBTlPOZNMdF9x6o4NMQiKk
	bMdw3YMHmH4bPaWj55INeefdB55LWO5PytFZmgiEccFT/TR2kwyaDEAbI75OGNaODxLzKKpTHjz
	X3YcGoT0wBEvk5FHPks1IWCPn
X-Google-Smtp-Source: AGHT+IFxKtN4MqdM2gDpwPd6SRGHpoxBytgfZTiGfc8g8PTZSK+gRpxzSn7VRwg26oj1n6BvjcMuvQ==
X-Received: by 2002:a05:690c:250a:b0:719:fafe:e822 with SMTP id 00721157ae682-71fdc2df5femr118396297b3.21.1756087307850;
        Sun, 24 Aug 2025 19:01:47 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:156:8000:24f0::eb06])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ffce104d1sm11087847b3.28.2025.08.24.19.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:01:47 -0700 (PDT)
Date: Sun, 24 Aug 2025 22:01:44 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: =?utf-8?B?6Ieq5bex?= <ccc194101@163.com>
Cc: gregkh@linuxfoundation.org, jannh@google.com, rex.nie@jaguarmicro.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
Message-ID: <379c80f7-aa01-4575-aa0b-d64ef01c1346@rowland.harvard.edu>
References: <20250822024602.42894-1-ccc194101@163.com>
 <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
 <4cdaecd1.131d.198dedeefe2.Coremail.ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cdaecd1.131d.198dedeefe2.Coremail.ccc194101@163.com>

On Mon, Aug 25, 2025 at 09:36:49AM +0800, 自己 wrote:
> At 2025-08-23 04:30:18, "Alan Stern" <stern@rowland.harvard.edu> wrote:
> >On Fri, Aug 22, 2025 at 10:46:02AM +0800, ccc194101@163.com wrote:
> >> From: chenchangcheng <chenchangcheng@kylinos.cn>
> >> 
> >> When an Apple device is inserted into the host, and the host
> >> wakes up from S3/S4 power states, if the reset_resume process
> >> is triggered, the absence of a reset_resume callback in usbfs will
> >> cause the device to unbind.
> >> By adding a reset_resume callback to usbfs and reporting REMOVE and ADD
> >> uevents in reset_resume, the userspace is prompted to reissue commands
> >> to re-establish the binding with usbfs.
> >
> >usbfs has no way to inform userspace when the device is reset.  This is 
> >true for normal resets as well as for reset-resumes (no pre_reset, 
> >post_reset, or reset_resume callbacks).  I don't see any point in trying 
> >to add support for the latter but not the former.
> >
> >Unbinding the device forces userspace to re-open the device file and 
> >establish a new binding.  How does adding REMOVE and ADD uevents make 
> >the situation any better than it already is?
> >
> 
> >Alan Stern
> 
> Here is my reasoning: 
> Currently, for Apple devices after S3/S4 states, since the USB hub loses power, 
> the reset-resume process is triggered during resume. If the original 
> reset_resume process is followed, the device would be forcibly unbound,
> and the device_attach function would be used to rebind the driver.
> However, usbfs is different in that it cannot automatically rebind
> after unbinding and requires a userspace ioctl to re-establish the binding.
> 
> If we assume that the reset_resume callback of usbfs does nothing
> and simply returns 0, the USB device would still be reset. When userspace
> uses the previous file descriptor handle to issue a command, it would result
> in an error: "PTP_OC 0x1007 receiving resp failed: PTP Session Not Open (0x2003)."
> 
> Therefore, by adding REMOVE and ADD uevents in the reset_resume process,
> userspace is notified to first unbind and then rebind. This approach avoids the aforementioned issue.

Doesn't the "PTP Session Not Open" error notify userspace to unbind and 
rebind?  Why is adding REMOVE and ADD uevents any better?

In the current kernel there is no reset_resume callback for usbfs.  
Consequently, when userspace uses the previous file descriptor handle to 
issue an ioctl command after a resume, it gets a -ENODEV error.  Doesn't 
this also notify userspace that it should unbind and rebind?  Why is 
adding a reset_resume callback any better?

Alan Stern

