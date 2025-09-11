Return-Path: <linux-kernel+bounces-812235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D495B534D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9319DAA1BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E35335BC4;
	Thu, 11 Sep 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InRDpZTU"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2A29B8F8;
	Thu, 11 Sep 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599601; cv=none; b=Lsu6Ou7SMdQs2pw1zLUdf033M/QjVeVHRMVCZzUgYkD9dLlPGy8aL+ujkS7QC7Bh3GSqrihVJQmK0fOFmq/37yCqL6bEAtbblT4AMDvdhVm1K+E9XEhWxWncp4UBa51e2WEaoK47A8MD+clmP1n2OvTf2i5knFksBtBMyjdsAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599601; c=relaxed/simple;
	bh=r/fd32BMQW5jA16SBItGqzeeWa+XuSVC32RtvyZrgbc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=GoSQsgm8Ydn6wzLfsJbYnlLCtEKV12pOIaFKPy6Ab8snZkU1pySBIbPXDs+UHz/OkD6b1rxIc3lJ9RCGxsfYhtAnvZ8zfn/6YP+RZQPolADvREmMk90eANND23zRgXxuQjIG+2TzT92EJu9rka0kTZLqEBI0mKWkQ/l8ULxd0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InRDpZTU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso781733e87.1;
        Thu, 11 Sep 2025 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599598; x=1758204398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/fd32BMQW5jA16SBItGqzeeWa+XuSVC32RtvyZrgbc=;
        b=InRDpZTUR/1luR7G4QSL6MIL28J73bKFfjL7kF8NQ5Xl/KDmWSJksQdR7igyTaxxjx
         I5X0Logq0bNojg9gJXYTanbFHrzM+xxFYJQxRKbF7i9XV7QOY6cukutS8uh+fNcLaqv8
         f72qdpISkJiGNS7Hk7bywOTN9OsWIZNV68WtIQ6/WH+Q+i3ltreLBbxwhYJeSivH8LD1
         cP1NnYxAeoedghSxAnWPQk2uUWYyMxRuimWpBao46YZvrNPguMQ1kLnnDAHesxUxyEob
         A7MzACzz8ZWdERI5ljh035/gPwRYI9ux26Q4VLq/cbh19XOO45KQS8KL6dmgIj4Dvya4
         hUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599598; x=1758204398;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/fd32BMQW5jA16SBItGqzeeWa+XuSVC32RtvyZrgbc=;
        b=MWcddFJ6obPWFsZE77lb8RgCN8ohOMMfbXj4E+tnSGXDaO2dohkma/SAdIyGl8wkQ2
         30lqQB9gCNtW5gt+Za7dmcG7LQYXjZj64pcrlbk5IpEgQR/NP5NTTy2sFVUgoBhaH6nF
         OAMVyhCDi9vtx4ro6PUSEMegjG3PyRDjNKUaIFEgSKpJnSmu/P27C1Dw+Ve9djgs1Xl6
         dhs8AjmmeJHKS3fQ/xm6+r/ovSckmPUxWhx4Li05GHcIP1phBPR4OLIH05guYmiPBCoZ
         0+ffe+OL3qeyB8mAPWjNlXFPts7sZ8PIXUlLngLW4QwRIPOaLJT7mJ8sBO+49e7fBuIP
         ju5w==
X-Forwarded-Encrypted: i=1; AJvYcCUofjYcGdnbP/1lhp7g4cwgrWoBVzfsOCUQZeymDJUA7ZzsWzHFUsA8udbXY/QbcUEgl/mAxNhYCJI+iJA=@vger.kernel.org, AJvYcCXNOfIALw9ClgIHIC0ocqHoYcb4G/hQx2DPiimzRNS0sfiyAyWB284NOuShyS3Qxin9IfCuf9IFHICr@vger.kernel.org
X-Gm-Message-State: AOJu0YywPsORWycRpFd8vc4/b5tkORoWSCz8Wpo+2Z36zkC/yULVYd3N
	k5+z/T3kaKHgMKygiK0OCm6USRCDU8AaIG7bBnDZj9ohOeQP+EKNaCTgXFYT2w==
X-Gm-Gg: ASbGncuOEvLcieEQVzCNd69YiTBYcooG1kDNhTocaCS42FGTjQ2R+Vd5Foo7RqT0kk8
	hGmuTEGY6b+lKgW/OtOpWdZaGGrZmCWnVYmkq2RwACmlU435SX1V+rdBAEX85jdcp7/g7RqOSzM
	yi2n/IFM6hCLNePMT1WMCNOHXkaBpHlDI79mQsXrhdJQ6QU2Pxr+1dCYXHPs4pjgla1P5KUQBPQ
	DYLH5fiOgmXWIVbX9YlmVC1EXeO6LtGek4vRB5rNGQvtMSVkZTKV50uHknCOhKwX8yKRwsYpHpA
	zyRf0F9WkxQDyyYsxcN41Mwu+zjAjWaoemrC7eBAjoC5qnMBcaThMACMTF+jxfvH+zpKhNrXhnN
	G2ci0mgzf3KtusBaJTDbGYDzjLAY4/Z/6/G/Br7pmycWMeQ==
X-Google-Smtp-Source: AGHT+IGWWVMS+k63AA7mnv922QVbg4VGH6ET7kmQLWfe0pDFnilfmjEVRfmcnmgpZgE3GGVb4JX8DQ==
X-Received: by 2002:a05:6512:b01:b0:55f:4902:6f20 with SMTP id 2adb3069b0e04-5626266807bmr6058203e87.27.1757599597384;
        Thu, 11 Sep 2025 07:06:37 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64bcf3a1sm429020e87.115.2025.09.11.07.06.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Sep 2025 07:06:37 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:06:32 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: xhci: Small cleanup of TD giveback and status tracking
Message-ID: <20250911160632.46245dc4.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I noticed some redundant 'status' parameters which obscure how URB
status assignment really works (it's very simple at the moment) and
create opportunity for errors like cleanup(cached_td, td->status).

Removing them seems harmless.

Also included is a copypasta cleanup and removal of some questionable
IMO logic, partly because it was getting in the way.

Regards,
Michal

