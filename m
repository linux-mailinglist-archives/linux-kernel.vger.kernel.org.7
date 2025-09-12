Return-Path: <linux-kernel+bounces-814184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39EB5506E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E18B1D64607
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECA30EF8F;
	Fri, 12 Sep 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvLYOQQT"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFC30DEC5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686003; cv=none; b=cUXZZ5b7cJkp+0yw5DT3vkayj1JBIQm/zRsFQR5p7a5zLsnklp/s6oT9wwArwfeFTaASv4JbVsThp7ViPC+PAz9TybjX+5c8Y8FeruCVKwXz1hBDVu4w++QB53UPazlQwiXZlECpH03OeM/BnoIA2XQzplkWSc+lLhINedtRrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686003; c=relaxed/simple;
	bh=FRlMTSLJ/LkYA/BzotLzFxEqgaYNv0EIO57ddaa3V5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHubji1N6byVptcIWV0wfrviq9D/9Wua1Y0yDgAGvv0WgXTygBMHzqpU8jUVeHL1UxlFsH2oE0fEmLqW8SKekwQ0gEXjppIjufPVpXMCW7QdiO81sQ/YlO9L4pjA1S14D9UVxYQ+YZkdTgSlszaKI+3bnfBcrmm6FAik4HyfQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvLYOQQT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so926103f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686000; x=1758290800; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRlMTSLJ/LkYA/BzotLzFxEqgaYNv0EIO57ddaa3V5g=;
        b=KvLYOQQTKRlNDceGCLFK+c8hxVPZiprSHAQjeyLthCQ/8qsFf5mE1sFc9hCUfwAEeB
         HIPBOAFSMDb5RBK2RoemimemunxB6kWlkYyqhvkyA2BOMx6L198XpV3Pw6CUfehAsz4y
         XUAR+TeLwa5934YGPsKfuWdpdRpuGG8rfXrZmf+FuCA0YYfkZ83UHaLMjuan/F4M+vYy
         RgqZMzg1KRQ5teOpK6DXJgCoRTPgW7/JKE90WmwDKfVRFvoYRydlM+xdT9PYP95Cb+4Y
         bCmXEm8+eRxpaxT8d7+3n22vT2tA5858baMGc+EdwwIajJ1OOIbd+lnPN9eAlHFPexs2
         1sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686000; x=1758290800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRlMTSLJ/LkYA/BzotLzFxEqgaYNv0EIO57ddaa3V5g=;
        b=bR+B9CogOaUinEFnHFq+IKo+X9pUZSQy3nCtlch2ZvMjADhbp5yLxAVhBQ/Ob1J+1i
         bxwLw6zHQ/JRft2U7q+iXtow1NKqxtzVj9fSD6YJZsvjlKXGiShGjcHqlosVIqF6FbDD
         UEuKuScv+T51ravJp99URR3ibT0RtfuCuIyKguskNGjxAEZ5WsZ+VfGKsak0Aqz6TTUU
         9P1nYsS1bU0w1dgwemQCeAgOnDrPUDv3wtg7CXsvtrF07fAX1nM79HDzEYBl51j8fwTM
         vHeVnAQg6FKccnwmcjKhHqPzjzNzehRP9/GYqTXJcb8ZSwTEXq5pMjDcWN0q3T6Kuftj
         AdqA==
X-Forwarded-Encrypted: i=1; AJvYcCUbFcE8kwwH0tcKb4Z8C4L2Sse1nyRGcN4XFwT5QK07PCPK/GGiJdecG2rsXlQtBLXP7qCFhwCR6yB2IAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07+l7HvNjBOYNM+Yw6LzCIIA3BZMR5xkFa4u/nOwuqOTfIT/W
	UkG2G/USdpAE4pv6kwmY/2w9cbX38v0Hk/agNGOiwYjKvYoxWDN4gNMd
X-Gm-Gg: ASbGncvBqTwtoHRIhoP7uWx6RmEm60WpktX7jMe+5hF4lGjweM7Wt/Ei8o/2pPxHT6A
	d74gdwsLvKaCI09ERqcxvF+AgtZ2/KATs4/VhyFBkX8Q+nR/kPw8AzRp9srOLVEKa1iJNyE+/v5
	zoxgjdypUbG8zZUycgvwXVKjhk8j4dgZ7UCdie1glSw8gN759PoyWCxT/wbAnxGpvv/iVjWhy98
	e8chhKFaQ8/36Gp2nAtdHHr7uPj6OwqMrDX0Ud+c32BtM71sZlQCjJscOvxqEatA/GKnKmD5PNV
	o6rFIdAZBuezljUCJXLt++gA1YEiud5WGyf/RlVHipFNjbse5QAHFrXy7ltI7B4hGoE96shOfUR
	210i7TUF4AmVJbbBvtiVZMg+Xfq99tbYaY3c727mAmMIoQ35HUev9oFQcO84o//c3TCTo
X-Google-Smtp-Source: AGHT+IEGTFi7JYS5g+yPa7h/IdVXR1wnmLz0HIzSvf9OY0DM3QOIA/rU3oyaswgIPXV5nn/ocSsxhg==
X-Received: by 2002:a05:6000:3109:b0:3db:b975:dba with SMTP id ffacd0b85a97d-3e7659fa51fmr3102179f8f.63.1757686000099;
        Fri, 12 Sep 2025 07:06:40 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd9fasm6600759f8f.35.2025.09.12.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:06:38 -0700 (PDT)
Message-ID: <6da404bc53aeb60f16cdfd1cc0bc70ee68a2ce0a.camel@gmail.com>
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, Amit Shah
	 <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev
Date: Fri, 12 Sep 2025 16:06:37 +0200
In-Reply-To: <601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
References: 
	<601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 04:56 -0400, Michael S. Tsirkin wrote:
> when a previous version of this
> patch series was being discussed here on this mailing list in 2020, it
> was decided that QEMU should match the Linux implementation, and ideally,
> the virtio spec should be changed.

This wording has been copied verbatim from a cover letter I posted to
qemu-devel and doesn't make much sense for a Linux commit message.

