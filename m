Return-Path: <linux-kernel+bounces-788963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8CB38E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59BB365591
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64B30F932;
	Wed, 27 Aug 2025 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyNSwioP"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4730CD80;
	Wed, 27 Aug 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334663; cv=none; b=CObU0CDpTlBhZfGRSnWwkPtICNaqTq4lF0Fxl084yq6AGi2kH2QT1cz29waINaZNwnJmaQk9C71xclpJ6WMzvIukvkNDIm24ntFV7/jOBxeABm2DxhsR0jz1tCDguuKMYEHCdCjzE9BRfJo/jaOSNSRx3oii49FUesSWDHH2s2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334663; c=relaxed/simple;
	bh=/yUgfiFEencipy3cbMv919gSm8VjsrUVB61Wp75DqIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unYi1pXR6W6BjTuSWgHoTwihnJBkitkTWQm+fwizryGZVZ1MX7fj96idN1gEnRJs4WbH5aFSLLOiyzcebT8BRsm3R7KhM4ufHCVeU0spRb4CrHfK9VFqi+HWnc+guHDinogucSK8gLK4QpcrpYaHHSwIp9wN2VeRGs4RPioHl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyNSwioP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcac45so2551697b3.0;
        Wed, 27 Aug 2025 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756334661; x=1756939461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwUqcyx60/hVH7kKMxcTFGB8KNjk/JKhOvJoDYdMGAs=;
        b=IyNSwioPnJ5DNZ6Lg/AE8C9Jtm5CBRoF6BrjWHsvYVtI4bKdqOFohGWx4AeuDzllvq
         6yUTpWfKC3YQiMbSxpB5m3f/9GTnr59k/mornhypIUChihNetgK4zYi1aF3XOGRV1cz/
         5mX57OEqpXyBB/JcCLT2B8gKjNjxj6QnOc9nKthuodase9N6WfLaR7qv2dvJ3+U4kyms
         lQJUYsIEKtQWhNQr8e8pFX6o8ztKOZkxq/rckakMN+s5xFJuU23BmPtZYWGMSkx5o+KS
         tBaeiU240sTwj/NKLHUXVNdnauHdqWsW9TJvxPbFK/yayZEDas3fTT8sPP2+cnfKh1Eh
         Zo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334661; x=1756939461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwUqcyx60/hVH7kKMxcTFGB8KNjk/JKhOvJoDYdMGAs=;
        b=iGcb8QdDobtZcNFrk1EPTz6IsORRBGbodREVGWQzUh3364PvTbCqbZjgS0aFdlaCa9
         8sujLvBFRNwXTZNmlrLXXB1Yvlpl33xLmUXOceSJp5d/FJjmycJSCsq68c8hIIpHRD1v
         fligIKQ+Rphkeu1yfko7/BWQTIYRJNG2BrO7vs2rrOmMcf+Kdd3JKniBmuZoTFpxXaR6
         7e+X0xtIyVm4AZ3VfAOFDOg7QlIyDZRNZO+tNvfgJXbYVo8niMW2gNe4qFw6ytIl3Ms3
         6CRx8PYZN2NxcZsSUgRqzS/lAjA5+QgU592p/3J9VBBikhqEap7MXSVDSPY+gvTzSjRp
         YQdA==
X-Forwarded-Encrypted: i=1; AJvYcCUUZnUiQJQNDAbpmsBNuIsdPivcBLGq7uQunN2yKZEY6eCh3AsDHETH8++w0DqezVsXoTbRujE6hsWh@vger.kernel.org, AJvYcCWOpV1x0K9SG6Mn1XJq9pR4iY1NMRnqZJSOKxGV203lMJQHm6BYxBb2gk/Pld1umjUxd/Z+Tr1Hu7K6KGhw@vger.kernel.org, AJvYcCXqvYO02yHg0EMLETfyThfu2wSA44BuUK1x1MxdPkPe/OqfA96Cvp9aj+qnNB8ORbjlpk39u0rlJ0ZkhXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HbeA3Sd7HHjdpOlDiPZhxzHdGe9drhbo++aOr1/ohOnO/ge1
	rbfBzU2lTzH20jHoZPqE+4pPuFGGzIMQAH79OuJZItyJbWQALGTI687KAUa/tKFe
X-Gm-Gg: ASbGncv0r/jqQ0rFPFIvVXIQOh5Qn80697JdJFB7bm08k9BJGE2C9rKWpy4mX25oehk
	uMg4AO64EpPGY4zwiwxg8KjBbaKwtdTyDPERYUDkzgzWRXJYcln5uF4zatq9CHOyWDZr2/zXAnn
	1sUi5ExOSIbW43qAqh5U5B8SEOoSOlyDAWuXcWDyaK/CpTbTMWONFenZw4P2aRXZq0UOAYCJV0h
	OKtZE/NCcE+DTQyI0QwLD4epQsGw4bacqrhZJkckVdTmC3/R6SXsx2DXEfQWfksSrwq0Uncnn6p
	OHLNcp//HBwaHGvPgwwI4coEUt4MOwGRYLZp0ky7P7RbaoFxJzSu3AYbZAJdTc2cb68rS2nFunh
	H+Rw5Zd0JIHYnTIqZJg==
X-Google-Smtp-Source: AGHT+IFuAUSUhO+Z4D6ZkaJYjQgZRNptH+8z6yXRxRHJsrFIqVkRrr1Vf81WRdJ2isSjF/uwz3rPLw==
X-Received: by 2002:a05:690c:d96:b0:721:1d52:1989 with SMTP id 00721157ae682-7211d523da1mr108376527b3.28.1756334660972;
        Wed, 27 Aug 2025 15:44:20 -0700 (PDT)
Received: from raspberrypi ([2600:1700:90:4c80::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7212005f70dsm18256417b3.40.2025.08.27.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:44:20 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:44:19 -0500
From: Grant Peltier <grantpeltier93@gmail.com>
To: robh@kernel.org, conor+dt@kernel.org
Cc: grant.peltier.jg@renesas.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: hwmon: (pmbus/isl68137) add RAA228244 and
 RAA228246 support
Message-ID: <c0c6e99e51b6fd4c5dbab02e02e4d81abe31f085.1756331945.git.grantpeltier93@gmail.com>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756331945.git.grantpeltier93@gmail.com>

Add device type support for raa228244 and raa228246.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 .../devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml
index 3dc7f15484d2..ae23a05375cb 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml
@@ -54,6 +54,8 @@ properties:
       - renesas,raa228004
       - renesas,raa228006
       - renesas,raa228228
+      - renesas,raa228244
+      - renesas,raa228246
       - renesas,raa229001
       - renesas,raa229004
       - renesas,raa229621
-- 
2.39.5


