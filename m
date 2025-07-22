Return-Path: <linux-kernel+bounces-741052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDAAB0DF80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567563A7B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74252BE03A;
	Tue, 22 Jul 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Ss8GIz"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7528A730
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195645; cv=none; b=alFfZND8g0lzbGgHIAWMARlXjQE3eDuxYZBg3AlVyZNYfewSzL5ahgDj2bQiHCJ1anhxKykFmGeG4ia+qaY6k/OTfL1KmATt7TZGf9a3FHO+fvJyex7Pp1htoUeySWynz1EUqtlx1gjyTWJBL7jMHkKbRKKHQrrCRP2R8RCGu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195645; c=relaxed/simple;
	bh=7EmfUNwlIO665ss9S8ZmODaGTD19asueU5U1VhKxufo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=h9QPv+e0MOpJB7tI3bQuI27/prv6eDuQWVxRI+CTeCU8529yxP+/YJnmmb5yQ4xilSfx/dF6RA79nubUmgzzL2aLdFFspq8VToLnKXAQBAvk9gawvyQ/er/qagRDAPAmteV3YsBJiIQKhm6NXCGVKHFdX2uTL9Mu4nsC+Y7YpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6Ss8GIz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae360b6249fso870750566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753195642; x=1753800442; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7EmfUNwlIO665ss9S8ZmODaGTD19asueU5U1VhKxufo=;
        b=S6Ss8GIzDN5DbEueWcQwi5/PgqMc2TDwh2hVYB8ftOA+nlNj7Ir/BpodYLrInZuoYz
         tVByT0hhmsTatriDnjfm4Fa29paHEZez9uC9xv8/Rt9xHTcJmh0GyjLDujdEUESbKx+R
         dWwov+QnWotE3KC4hnMBLRpxn6eCYOXhL3wLa8YNViiwHfJGdn2JBZNOQQtTrYMgX3vL
         +8BTPNCgRwJOB0tmfhr5u/JDBDxTB7P5ES7PebEago0vk6B3BzHQIlaaJdZjJrBGRurQ
         8I5gt4Ss5Os5M+CR1EgNTwgxY25dINA3t6zUdTXQbqeia/E5f5CtnhiYHzrrY2gxyGjn
         bL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195642; x=1753800442;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EmfUNwlIO665ss9S8ZmODaGTD19asueU5U1VhKxufo=;
        b=RS8Y5UqGNqo2JCQEs9haabiFBkArvMAkCWgw7wP7ja/JySywEHg24Mi98OWIJenCUZ
         HHzc/3Zxd20yT0eKjUZitJ97INmxlL/nAavA4i3oNMqJdX6nFJfWFbQKLoFbc8riK/kI
         V68rNmu8fPrL0b9w4tD6lEAomSUh3xo9apzfwrDFKkTfKGvTCDUmSmMbfIj5mmUTFhOH
         dDd4/9TD+ajYF0E1GFPyG455F7PPC6qoi2kTqJNjquzXaPqwaNFTvouZgVDUVxxDqtm7
         y60dXtZSf3mspQeLpEmeDJu7XGjWkLftWMI8VYXYY7jxW6ZBF71zpAv6eFzFAy9fIqDo
         Z4dA==
X-Gm-Message-State: AOJu0Yx9R7mwk4kNOkoyQuCpreKfg0jslGJW4WhLUkjdGSRLdwmqqDVz
	P8395DzTEK0be6Wxu4lWYkcXUKffasyg13NWYmDH2EVAAvJROXYeCMWwYu1B
X-Gm-Gg: ASbGncusiv4w28xOkDGO7pov0xXoPmoI8JlJmpUe46V8qnMG7GZmIkwvh1e68imdgVf
	LbB30VRO/ovMeo7jK8Ceq6XqWvB4acqwLTwGRZZ+7IJDziHRfGNjLNDmZAKNkHVaBodEYbH76th
	+uatJ7gEa2lZ9ouH5noxLuSqwWXSkAe3xS/TzWAfc8Zn5HkrK6lF6KlPDnUB01qnt2+04jpsEEo
	0O89dyVZn2rwPyZVMUNni1XTtCvIUuu0Xev5w8IxLt+mo+bzRzIcBRU4n7hRyADaaMLNJ9lmHZ2
	UQUOVwm9L/796yjdZ12OPbCOxZt/u2UHZUj3gcTBZ5w+Bzb9nwoxLj+YTLxrXxgdawmd19c4l53
	BK2yTp7gp8p2RHFAjQI4OZBbIkVdqe2refdlY1pASSHYf
X-Google-Smtp-Source: AGHT+IFaMRrNfhEgVO5i1o576F3t/nihdWLY3NFC64anU1bqr0GI/D5yV/VnKdEIDJSDDIQr+GVFOQ==
X-Received: by 2002:a17:907:9809:b0:ae0:ce40:11c6 with SMTP id a640c23a62f3a-ae9c9987810mr2266191266b.21.1753195641366;
        Tue, 22 Jul 2025 07:47:21 -0700 (PDT)
Received: from Uzair ([39.46.230.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90d401bsm6945670a12.70.2025.07.22.07.47.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 22 Jul 2025 07:47:20 -0700 (PDT)
Message-ID: <687fa478.500a0220.2118ed.06d5@mx.google.com>
Date: Tue, 22 Jul 2025 07:47:20 -0700 (PDT)
X-Google-Original-Date: 22 Jul 2025 07:47:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bruce.mypackagingpro@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Personalized Bags and Boxes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCldlIG1ha2UgcGVyc29uYWxpemVkIHBhY2thZ2luZ+KAlHR1Y2sgYm94ZXMs
IENCRCBib3hlcywgbWFpbGVyIGJveGVzLCByaWdpZCBib3hlcywgYmFrZXJ5IGJveGVz
LCByZXRhaWwgYm94ZXMsIHNob3BwaW5nIGJhZ3MsIGxhYmVsIHN0aWNrZXJzIGFuZCBt
b3JlLg0KDQpTaW1wbHkgcHJvdmlkZSB1cyB3aXRoIHRoZSBkaW1lbnNpb25zIChMIHgg
VyB4IEgpLCBxdWFudGl0eSwgYW5kIHByZWZlcnJlZCBib3ggc3R5bGUsIGFuZCB3ZSds
bCBwcm92aWRlIHlvdSB3aXRoIGEgY29tcGV0aXRpdmUgcXVvdGUuIFBsdXMsIGZvciBh
IGxpbWl0ZWQgdGltZSwgd2XigJlyZSBhbHNvIHByb3ZpZGluZyBjb21wbGltZW50YXJ5
IGRlc2lnbiBzZXJ2aWNlcyBhbmQgc2hpcHBpbmcgb24gYWxsIG9yZGVycy4NCg0KVGhh
bmtzLCBhbmQgbG9va2luZyBmb3J3YXJkIHRvIHBvdGVudGlhbGx5IHdvcmtpbmcgdG9n
ZXRoZXIuDQoNCkJlc3QgcmVnYXJkcywNCkJydWNlIE1lZWtlcg0KUGFja2FnaW5nIEV4
cGVydA0KTXkgUGFja2FnaW5nIFBybw==


