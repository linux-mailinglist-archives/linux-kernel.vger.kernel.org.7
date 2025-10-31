Return-Path: <linux-kernel+bounces-880664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86469C2649C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466CB40264F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38733302141;
	Fri, 31 Oct 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEhHOHlF"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF02FFF84
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930369; cv=none; b=GcAB49RCkS2d1BcbZ0l8/xaOPC+KvudVvh3DkRmxh726YqNLUIb43Xvztf1WeChffCpn4o2DLkKmxH4i+Xb04qLJpGVg1KRloDwnCKBipwfoqzCe7uK85s/XhyO/8RFfY/S3Ox0Zk0Ybz3lGbvDiNnBEwH9qCbp58S4MnvOKo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930369; c=relaxed/simple;
	bh=51HoynwOXBBYpmRQlOlZjPk3WwgqcaDPqx5ZdB388U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=foN1mcNjwINVCB1yItxXLloiqMTnMF5bDY7pKdbS8BGynlZ4lpuaj/Ac9dJLXK4c0qk8ltKxbEhF82B4jbhqrITMc7NfhgJLmpxbGy1sT3PrhNFl7/qa3Rs2ZKJ21yO6b/OTVNFjgO1l9NZTY2BCtWq0I4FLZociH7weqpXUmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEhHOHlF; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-9447edc234fso638653839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761930367; x=1762535167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESK5VZc3vh1v+zY2F8OUAm49V9ykNX+vVejA0Uaau+g=;
        b=EEhHOHlFoK8+f5QyodcEejOWF9NHTz8GF8TlT81bD9LgXer/sYSYtrIqotp8968gu/
         Vr2zyOeGfCV8XUZqpl8kxujf4cBo0dQxqGJiMXLdfrEce2J+dvsGlNp5s4ZNpOtorKvB
         PID+OsnWbrfJzcaRtGja/o61M3yXnTpGltTh4KYhiHj3skAVW+FiFMEp6OGhOIW7fKIr
         vj2r5dBMsaAGoCR7SrGUQXwnf/jZcWOzoWC7u+a2ynh3rxB2HepvmlzJeEWYqhdIyrJX
         Ll02J+CrQUkMArgEz9/gI6Tszu5FJ/vpAad4FO7oG4sei7itVOa6hE3YBLFtcbbqfyvB
         ncjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930367; x=1762535167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESK5VZc3vh1v+zY2F8OUAm49V9ykNX+vVejA0Uaau+g=;
        b=ezp0jznawfsvtA2tnG4K3it1OPkwaR9cnHoctm95wqJOHXOIXgV4s1tyQQ5iNjkeAY
         It3aEonAyF2uD7Gp0i82dRubit2s3I8AfyEwEbdX4UefOPQRw2jaFYSK3zykw6Ys5rkG
         1Pwc98pnqp3diwIOeKjcF3SeFz23XzakJmP6pgZkvfDBTmvCNrSHvxSA2QBaT4oHLU9p
         u594Fge8UWl1mp62QeOX4lKZmb4wWo6DMiQQ5lcsylKqWx62rKmJTSwRfFji6qJW5c/Q
         wp2d7keuTJ/QUNnzRoXoFi2ThCzgD4Fp6gJRy2jctd2Vw5J/UJflNov9AEPfuB3kMEYo
         lJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVnHwvE74L9xWgKas7O3CcWxdRhA8IzjA05z4a3rjHvegVKVo4+Q0IpZAKDvey+MheowYyJ4cvRq0Q73WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXy0kG7ZbPYic0s7MPKzy8DiXMK9IvDro3Du1rZaiTI7jCOdBg
	xAjYi7PTh2sKS+EGzef+8FDSlCjMizHHzJbFivUktAU6NhXJvZzeFZqvYrpG2JfPFQvQOckmxD6
	MbKF+qKrdZw==
X-Google-Smtp-Source: AGHT+IHDw1+d8/l+qhwB+hEV3+qa8J59RyQJZwYBwBtApzCiM87vIs6ZU3Urpv3R+3PkP8aNHR918I5o62+g
X-Received: from iobfp5.prod.google.com ([2002:a05:6602:c85:b0:945:abfb:6eb0])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6c0d:b0:943:5917:b6fb
 with SMTP id ca18e2360f4ac-9482274fc8amr725849839f.0.1761930367031; Fri, 31
 Oct 2025 10:06:07 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:06:02 +0000
In-Reply-To: <20251031170603.2260022-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031170603.2260022-1-rananta@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031170603.2260022-2-rananta@google.com>
Subject: [PATCH v2 1/2] vfio: Fix ksize arg while copying user struct in vfio_df_ioctl_bind_iommufd()
From: Raghavendra Rao Ananta <rananta@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Longfang Liu <liulongfang@huawei.com>, 
	David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, stable@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

For the cases where user includes a non-zero value in 'token_uuid_ptr'
field of 'struct vfio_device_bind_iommufd', the copy_struct_from_user()
in vfio_df_ioctl_bind_iommufd() fails with -E2BIG. For the 'minsz' passed,
copy_struct_from_user() expects the newly introduced field to be zero-ed,
which would be incorrect in this case.

Fix this by passing the actual size of the kernel struct. If working
with a newer userspace, copy_struct_from_user() would copy the
'token_uuid_ptr' field, and if working with an old userspace, it would
zero out this field, thus still retaining backward compatibility.

Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
Cc: stable@vger.kernel.org
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/device_cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 480cac3a0c274..8ceca24ac136c 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -99,7 +99,7 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 		return ret;
 	if (user_size < minsz)
 		return -EINVAL;
-	ret = copy_struct_from_user(&bind, minsz, arg, user_size);
+	ret = copy_struct_from_user(&bind, sizeof(bind), arg, user_size);
 	if (ret)
 		return ret;
 
-- 
2.51.1.930.gacf6e81ea2-goog


