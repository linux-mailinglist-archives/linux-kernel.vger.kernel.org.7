Return-Path: <linux-kernel+bounces-895988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBAC4F70B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756893B1F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40B3A1CE2;
	Tue, 11 Nov 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs2XsxAq"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED726E158
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885761; cv=none; b=iMKphJdhoqQ+n2O3HZQoMKXg0xcuxYrG4Z6vt5ZezpLxFNTGdJWelVATSudmzN4KOIJj4Vo2VjgPzFqXKsTKjQK8THXibT9kRGmMHJkt2jxWAVCc6T0hVoIm0uO0Aa2ZMs0tFP9RlIvdB77ytgcQfY7xMTU9a998UDbGb/E9gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885761; c=relaxed/simple;
	bh=yyjKttti8LUD7ojC20WHyCuree+qSlftOHV1FAeKyVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUZkNjG+5+k8QxMLNfeRvTyljJrrRXWp/IBj+l9yyUDh4K9K2XPbPzq5dQSZzuq1oUTPG4eQ6fmP7K20RKyX3T0loCHWz0R4N7h4b/skW0Ew3S4bF9U6b81UML4JkXCocYbcru7GaO9G6tdWcAaMMFswuOsfliKaJiyAwBSqIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs2XsxAq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ae1c96ece1so4459b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762885759; x=1763490559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYLC74BmRstgF3ZNP+ON4FPUdIu8+29iUYCK2S3MgGc=;
        b=Gs2XsxAqoem5pNq+qqD4IuDkHSOH9xoKaEXpHZha8gD85dXqA4/nOyZm+lXbM+DLKd
         OI6guysWaxwjai/+g1u12MLdEOU7zxmZvGZjfVcQdLexXbDGI4iVQ4ur3MuGdkSR6yws
         O6NsLGrsXRuSDXEUzxufGiozMAtlFsgjgDL0/Gpqthb40SrEZbi5L+dqzldAWzaU1xOI
         0kUK7PO4MDqHeAJlDDl29AJUbW46ns4o3uJVt6xG4m/G4lH9BgTDJ1UT/8rvJimr70fO
         mYrOqRGP2y6CacTbXtZ2pJcPcV20aC3KdU5VDTimbg9sXywa3pWnUhbPMXSrdfm4Y/Ch
         O8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885759; x=1763490559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYLC74BmRstgF3ZNP+ON4FPUdIu8+29iUYCK2S3MgGc=;
        b=IVvAG0MPMp30wDMXiZ/sRAWeilQNJrNZtrbc4AZ4alxWDzVhoZ7bhBk9+D+XoLO516
         jmMWFUezf15gwbTNRV76etj9wD11i3fBhvupzTLDGjsGMLaOTnQj4QPr+xIRn99jVfCe
         +Og/RvKk/tm2zsFZy3UuCGnq6escd1AXJ3XBx7hEDmh5WETXVvL1mLbNvuzTOHUYbM+6
         LlnfJGbzf5+RWEA7KTHQ3f1EhyxFMVfcM7khLMs2WCWO/b+T4t6uuZ76mxUJoXMoxe0W
         JHzfZkrbz1tsJDIUCsFdams+fFLdzN9HmGoJLD8goCZDuU2Xu/nJULxgg5ksaNfV8bDX
         AYyw==
X-Forwarded-Encrypted: i=1; AJvYcCVn68zl1/2dcbO/SkzLioRwqJWj3YvfSIPWIte5qz47TNrFz352mHTVb2kpE++NSy5O+7t37GhaKw1PIMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlqj1rhxaNtv10Z7kIxq208J6OfBHJFUgLxek4wCbZIWggrtpI
	qbrt4U+RUoDzXvRraIRDl9yAwBIFhN2gE1LgZYX0bQhnAwoQgbjzaSWE
X-Gm-Gg: ASbGncsW5ybD8X4i4n2Pk9bZe/XcAm9+543OooAz+E87xHRuWBAsuVZBrqbC/IZNU79
	Aeollv6BivbWTaay14EvvycPn7DSV2c+YyTDRuqC4D7h2aPARToJ/+WGNXWih8o1/2tbjSSQ3S4
	KVRWcdnZisDxerxKHm/7wXeQRmaLm8AQ8dhd3UCQKv6RzPR0D0kCApKs0FDYVY5Oi8si2lRNEtu
	C0MJAEUdrdUiUKlqJYXrBp5vgZB60+hgn9al0GrTDvQxONOSVf1D5GQZ37lFaEhBxCdV3mE2GRY
	qb0nFM8fGV1vnPc84y2XwputeA8VRfVW/UG9yBz7AXNW6qOOkNoP7xwlL3iXkxiBBKX2cRIeOII
	8Cln7enSI0C48R2M1WenSOiO77gH2lz3NiNjVyYDay7MRE6AgvopuHt2c5vIXFzKfAgMavlg+tR
	5wlTyQgT6Wnm5YcniFBuViUo3e3deU+LJxnK44psi2VNfUcd6Z1hqu
X-Google-Smtp-Source: AGHT+IGoGOUQM16zfvCuyco5c6sDrGrLlf3lYUHSXllVYJllzDG7UdRaYlDMTupwDUXMaYQG/fdPMQ==
X-Received: by 2002:a05:6a00:c88:b0:776:19f6:5d3d with SMTP id d2e1a72fcca58-7b61b4987e9mr3019530b3a.2.1762885759164;
        Tue, 11 Nov 2025 10:29:19 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:b44b:35e1:6571:ff4b:b5ee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc868fdbsm15670157b3a.55.2025.11.11.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:29:18 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: johannes@sipsolutions.net
Cc: dave.taht@bufferbloat.net,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linville@tuxdriver.com,
	skhan@linuxfoundation.org,
	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com
Subject: Re: [PATCH v2] wifi: cfg80211: Fix uninitialized header access in cfg80211_classify8021d
Date: Tue, 11 Nov 2025 23:59:07 +0530
Message-ID: <20251111182907.6042-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f3a9797eb23d9c26007652798f14b76330aa1933.camel@sipsolutions.net>
References: <f3a9797eb23d9c26007652798f14b76330aa1933.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MPLS seems to not have this problem.
  MPLS avoids this issue beacuse  skb_header_pointer() is used with the proper
offset.

> And maybe there's a similar issue for the VLAN tag?
  yes we may need to consider this(header+vlan)

I'll update the fix by using the skb_header_pointer simillar to MPLS.
Thanks for the feedback.
--ranganath

