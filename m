Return-Path: <linux-kernel+bounces-727001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F7B013CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E7FB420EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B01DE8A4;
	Fri, 11 Jul 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IXtUDqOZ"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D881DD543;
	Fri, 11 Jul 2025 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216044; cv=none; b=ogaOjRm/z0fkYX6ciN3GgQX3Q8YAq1WBHplgZ+rVePHMoZCgdUY6tUnPR8Il9m7eganr7qmNd3duJyB0OEt3W3v/R/dG1mFGigdhDK6e4p0tddWRZ0+NR+MoXhNkw1gt+yP1k9nMVlkJr6y+KYUKfTD8ybtBJhuj0i4+ZByISU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216044; c=relaxed/simple;
	bh=bRgl+pfnZQsF9Mn+0aks9HldgL30VICTSE9hXI+bmLA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dAZ9xhNp2RGug/PCXHcXW0q3DnjcIEVcssMAx/FvVFj/6AVyL4K2B56WtUqThqxa6sk2dpGnNMqrBNjb9jBDIHj3qKoEx2pGtH6Ld2Gyfl8LFSmKjKsh752cABBu1UjC33chafmIKRbbzqw/lgk+WJ0JaNGmSwhzCx2yNb2qx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IXtUDqOZ; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752216026; bh=YDlIyQJTZ2554dWE8oK6KsDhFgtAe3WOYzTfEjV7o48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXtUDqOZ/WO7cmEbNtnNTe20MGgknmKkDdLyWJSEh0jIWUr60cfA8q0QdBP3gIVlS
	 iCpURbk779gxutJb1NUaI9RnLDU7TsRjS+v1FOiCi+uEiOlGlCIVR0/vujZVCB4I5J
	 WWB101lT0yOex9IP/nhBbO82RDXrhQYl0x49HsFU=
Received: from VM-222-126-tencentos.localdomain ([14.22.11.163])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id A1933439; Fri, 11 Jul 2025 14:40:25 +0800
X-QQ-mid: xmsmtpt1752216025t3anq70g8
Message-ID: <tencent_693B44F3060A525A26EEC5ED8DFF5E92C906@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjWA7/i1N9OVJ7l1hylna8h4m/IT1A3xcwwwcQJm5QPOjqZNsfVX
	 KNeWxJIgLJy2v9yRvWsDDkDIbJIFmtreS8FHgC7I31bynLFghoX5RHzbaMWQJC4kq/uPjDVULz9J
	 89/BdMJbMM6hw2yI4WyQFxXk9KTC5c3TNl9sz+FeHUkQupx3n312hpe6HMt3yPXRHnunkpcrdw+L
	 jIp1hxy+AmExNYQMpvKH25Rfuutb0oY1ykMP0jVfZOPC8sMEikfR7aRPt+j5y6v2g0hiwfPszUBL
	 l4ePf9SofveSuMJLgOv2kNeNy6PZe1Ux88x9ArwmMm+K6H4gvELS88L6fjyzBwzf1arfL+zF89fX
	 fmqR6ygTFy9F/EYEEEHB0psXShHp7StjbS7OYMrCbh5QT++e4pwGpG1OdAT14iQwPtHZdMXY+rrF
	 8B2ky4xipX0W8A2UIGAcFOrkoTkZO5LuMC16NlPFaP1qGcuklgBKNrWZgYODsakwH0ZKr595rM61
	 SrabvatiBcXhXFmo+0SPhyphjkPRid9Y222o0+zr4BXh8/X+w7s51tKMgmZS6jY2bMXD4pmdLbmq
	 FIvwn/XLkJEMn3rBv+/zQv4Zw4u45EU9xDjw6v3IparX9wraG9hT8jjLX1rhwcDtcekaLiYl7XPf
	 TRYeJEwaDXmBL/WF/RsCHaYqpzpOibxk+B8ZPyCE6Dj6gQY2r9ROXkGLiNhA2LxclKIMD5lcnczy
	 Ro8DJVeBPQv6VrkZAZKuXd7oNxd3NCddfRTg5ZDFeg8ZB6OpgatTiUxRq9gsCDPNS13bdTGZFCZ8
	 YgnRDPUrHUGvys91Iadd4Q9Rk3KhVQc6ZyHw9wYDvBk2Tco4tkJsyg8oRWSpWYkIh94Qn5rGUTuc
	 /wNW77BMH1zCIo5ZVb4l2JdOubGVU3rRNTfYfsVsgAvM9oXcyuHU6bRC2s6sleNRwwwU3TV8NI9L
	 YQ7IhNgegU+UJo1YOTO3/X8fmAM30wVrMF5rco1YVKdr8Y8zGsWO4GSiGhXBBb
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: jackysliu <1972843537@qq.com>
To: gregkh@linuxfoundation.org
Cc: 1972843537@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Date: Fri, 11 Jul 2025 14:40:19 +0800
X-OQ-MSGID: <20250711064019.3559575-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025071150-removal-bullring-5649@gregkh>
References: <2025071150-removal-bullring-5649@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 11, 2025 at 11:46:35AM +0800, greg k-h wrote
>Sure, but again, BufLength is not used for anything, so the value of
>that variable means nothing as far as I can tell.
>How exactly?  Again, BufLength isn't even used in that function
function contains below code:
if (gen_ndis_set_resp(params, le32_to_cpu(buf->OID),
			((u8 *)buf) + 8 + BufOffset, BufLength, r))
((u8 *)buf) + 8 + BufOffset determins base address of buffer 
and BufLength determins buflen.

>How was this tested?
>
>And even more importantly, how did you find this bug?  What triggered
>it?
I detected this problem through static analysis and calibrated
 the device via qemu emulation.

Anyway,this problem seems hard to fix, I'll try my best.

Thanks

Thanks

Siyang Liu


