Return-Path: <linux-kernel+bounces-792543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3645B3C565
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E36A21600
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201E2D3EDE;
	Fri, 29 Aug 2025 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A20U+uUh"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D488F48
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507936; cv=none; b=tGdTnkJH+L/b1wblyrR/GnPfSl0YqPYma+pwNFjg16p41lW9ibOEcOVevjZsgx7ofYqZdey8KvE1rHycFeo1H9Y6m++cQPqTJcUtJLIItwdvHIVlqVbUdJ/WmzWbJlRuIqbaPN6Pr1zt0YwD+h4JNY/uKw+cbWFsClPRDf8uMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507936; c=relaxed/simple;
	bh=HsQmXUeB2wVwAnWkEYNVi8GOTDlUFMitKMLoIf4TsCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEM9sQ0ih3guYWJyjGF9gYgjixBLrW7LMm9VNKFGEMnKcor7NCPLFxSVsJ1KqrrJE+KkHq5YcyEyNptr4EPjEuHXR1pZqp+rilJ2DXcViqT38awq6FdQQi5G1JHC8zykjNESmXdEfWbR8xRmlRDQwTwx9df3S3xU7ZFZy3hbII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A20U+uUh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-770530175b2so2076225b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756507934; x=1757112734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ub2Ww0VQ6nRQD2cRJl9mOGNTS7FBmsfYEZ9UU3eods8=;
        b=A20U+uUhQluHtZbL0mXmRMA4sw3fH6X2uh0t12ufxOBtyow4uyGcWxdeWhOr4Y0m+C
         +gVXxyW0llH+sXB//9veBRh653Bo8xBM4HxLuRlxpLHZkYA4RBf7nXdkoQLGQDwZx3Hy
         2C8WjGZcDQZ381QR9GVPfAPbOkSAg/TKCILlZEGEcVPgEB9L6Pk2lOIWati0hny6rPbm
         bp+N5Fq/3OLzZwnUvLVYnpln226MI82goRmiiKDU10pendqs0gku9zF3GRX8iD2hyXW8
         I7BbCHw2dt2/VhMbRtbM7rfCuXf2+qW6hCl8qK2l1MLRETV8pJhmULN7pUQcVuefPOmH
         LdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507934; x=1757112734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub2Ww0VQ6nRQD2cRJl9mOGNTS7FBmsfYEZ9UU3eods8=;
        b=JPH8QCcOiGV5BaLqx0pwrn1Q//ZFyQbXzW8/4Av6YGE49a5sXSXm2SBgrZ6C+t9txw
         tiMvHdE1jz/gBhXgmZ7YwuzciqwYzWEGVj0wuU/2/4AinEHp3o4pRXkY05Gu93A0WKD3
         E1X8BWIIMuQHg0O3pAQ1eeEysJLhkrekYF+AZV39mLjIxrtrjvKSaf0fOhTs/OcYb9KG
         v1lRhVnHRbAwo+VpD4haZ3zPKLAKcvXlSwO7ERWENyy3WUQ8q/5IAN1TAv84aoUWxnW5
         6QN9D+bYuKtnvP5BN0onYcE/opVJMn8sdXewtLStrpYlwAnPuHM3Lk1VJClPXSiHgznJ
         bfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpIkr+XblPOB90C3qj/Clt0pjYwJ4CIdfKYfNDPk8O8aPec4BOWwx0THAIh/RPDmtRvxGsKspxGs8viiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIh1v2ERT6uLDIqnWcvZXvbwambHwsdNzQ8nzKEoQoYU3M6BqQ
	wQKU5ianewqqRnzVpGCtSYRgunPVIACzFGqDnY1uI/Kw8e0CsGDhpJkF
X-Gm-Gg: ASbGnct8U4pZX3eCMvQuPuzjxL9q+/1X+zVnWFHD+2WzEWejwwMfVg5N3CK2+CN4N/R
	ZklC57TxVazdrukMCEnwnpfUtuXtzoSs+cA1d2/liqDq5rirBvZ63jvn/I5E4csro2B0CTBTm5u
	gt815CFwvUvM2DsIqg1f1trpstlmkZlGsv3OMtYu0mpnx9jWagkr7EYt5Q7cAA2jEfVBUqYIUU0
	FiTQTffbPUokFcaRCFzeDUsvaCaO0qynXLv27qB6/A1kKW2u3PsOqfEOdsdABYM9DAkURZIw3Po
	WU9rv5ljRe0jSvylgI7pFF9LnKrS3v3j5hQ+5USstWjZ9UdZaMHaKdZ5IN3GcoUZNGI2kccW1Zw
	7YYOWCdrGvYLJZEFoJgFqyFNchpuG0QKVKUsJU8VcsZOdU5JfvSvSZMCF0CereCKK
X-Google-Smtp-Source: AGHT+IFzWvz4pQi+E6K2m0w4vMz/X4+sVa3l/qLXBdfOtJ5zgENKlC982L+s/HdfG0gdcnJyRJUeRA==
X-Received: by 2002:aa7:88c8:0:b0:76b:e936:607 with SMTP id d2e1a72fcca58-7723e0d3420mr291138b3a.0.1756507934178;
        Fri, 29 Aug 2025 15:52:14 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm1065519b3a.67.2025.08.29.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 15:52:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:52:10 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	david@redhat.com, axelrasmussen@google.com, willy@infradead.org,
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com
Subject: Re: [PATCH 01/12] mm/shmem: add `const` to lots of pointer parameters
Message-ID: <aLIvGsEvXSoNDbKl@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-2-max.kellermann@ionos.com>
 <CAJj2-QHVC0QW_4X95LLAnM=1g6apH==-OXZu65SVeBj0tSUcBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QHVC0QW_4X95LLAnM=1g6apH==-OXZu65SVeBj0tSUcBg@mail.gmail.com>

On Fri, Aug 29, 2025 at 03:44:12PM -0500, Yuanchu Xie wrote:
> On Fri, Aug 29, 2025 at 1:32 PM Max Kellermann <max.kellermann@ionos.com> wrote:
> >
> > For improved const-correctness.
> >
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Yuanchu Xie <yuanchu@google.com>
> 
> Appreciate the work. On a side note, Andrew previously mentioned[1]
> making the actual parameter value const (which is different from
> adding the const qualifier to the pointer). Longer function
> readability would benefit from that, but it's IMO infeasible to do so
> everywhere.

+1

> [1] https://lore.kernel.org/lkml/20250827144832.87d2f1692fe61325628710f4@linux-foundation.org/#r

Imo the lack of these value const's isn't a blocker, but it'd be nice to
do that "For improved const-correctness". Especially when you're changing the
line anyways (see mapping_tagged() or folio_contains()).

