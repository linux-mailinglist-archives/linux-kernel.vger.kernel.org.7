Return-Path: <linux-kernel+bounces-751037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765CCB1647B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9763A3F12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADCC2DE70C;
	Wed, 30 Jul 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U7v++QGF"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E02DE6E4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892279; cv=none; b=AcTcFzidAoMLVIm6J+YafAgBim1KWUZf4hkvvQXVgfVkDnRYWBfT0cbwaljUX9wDkMxfOgVEU0zXEa9OlrmLN0B0IHDEiQL4uFpwh2j3sOksOW5pm5GbWVvGLEfo59xtd13lzo6v1nMQCSDgI4VYwEXvkGT91TI7PH0pJqsVJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892279; c=relaxed/simple;
	bh=T9egW+yuDv1sdibbS6gTQqeKitnpc7cvJCDpV0e5Zl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDgXwqtEQqCBgqkKgotge4gcjD9u9b1EMkXf8VPKLJSMNwWDmKSPbyprM7Ustlnsry9dG0RnTSutcw+WxdvYVirUF6Wh4yJ+czA+BlVdGarUrPVx+Gzae1gDuTfrN1GqgigiBiKr3XMS01+X3/peT6PCQQUcgZS9snUw9ReN+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U7v++QGF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b56b1d301so4747443b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753892277; x=1754497077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKVXiFSrRnWYZjHB7PInXkzk5lBOY7fcLObrtGYxkVQ=;
        b=U7v++QGFN2/iFWL8GFW0Uwcdrx9IdXpkkCZuYP5V+sF742SEEsIWW/hhiR0IDZLf76
         npMG4kSH5D3fq/NhSszdfaQAXIYPxrv12pqTyT8lkEGfTMmQ4p6E4KFA4E5bgUlpetB4
         H1/LbJNF7GZ6jNLRiKuLR5a9xVKUQnAwCs42fIgUedxim/TV8NYZOjQI81PrmV1Mr9oy
         0MAsf0ZFpjG4SB/mEdzKxDHurPkcqaemhqqFj/2Os81eN8Voorr0ViZ3z7vnpX3p7McD
         fR6SFXvHg/ATIrLozTeS9oWWF3WOAnM3CFxln9NC9JAmzqxWpsHgOMeKBjB48ARoTZ5i
         YEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892277; x=1754497077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKVXiFSrRnWYZjHB7PInXkzk5lBOY7fcLObrtGYxkVQ=;
        b=gk95ZBXuH5MUoPDplH6aKYYCfn6qGgPOdn8FZV9zi0f1BW/H3Nd76tvUb7H3vCxpKW
         1bkW1QJnIOrFiSwsqXF4UIHxJeEGAXRfR2GBn8um8qQeVwU4kg+GFc47jrZ4/0GorSP5
         5gRznojbULcFJHoicK/I8dL4N6yBxKqHjRGP5qVJavhi9lIH+y6RlyhSbgd8y0jMDiu8
         uAbbX6DoVrqTr0af4WsG2TLFHxsMuJVcy0QiHf48pj4rCl9noxRtygIjopQOJrTvLAHY
         Gqy4qnzpbCcHiF24ln6e1UGiWvWBxcqfA1KlVm3Q7FOJsrzVwG8tV7eO+TJAyvlQDHUY
         nN1g==
X-Forwarded-Encrypted: i=1; AJvYcCXxqr36+g6WnFp03HQGwOcurn9dFcogTYLHMyPy19HKX04G1Rw/8sKsK9L1ixQSyXR61IA5q40lAoNBExg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy379zECUA0vd5NDuD61Drjcosi+KozrBH/T0MT5pDwIjFmAbIL
	0Hi8KyerFuvxO6ZIrJO8YyAzc+K5wd9Fh2JBv0jKQQLrsRVlY53lYxI5M34MAm4GQVs=
X-Gm-Gg: ASbGnctc/emrbGO56X/h41TIHvZgQZ3DqqkS/LRJRZJ5mk1Ij/ElfixMa9mzpXLHxcT
	XvSLlbTBRxL4Wzn3nJzg7+SCc88z/FgFCmCNVsZDgJBXm+1WwhGAwiBl3HbfSw9hiv00VebD5Mi
	IMCzHLXh5VUV4xcEmK2Vc8kqUASjKt+RWq4ShkLpdzeloR7BGWD3fVa8sEJCLak/1k8nk8YnIjj
	YC3iNBPGhNaXD6nib3+Pq4+RpKDbH+kEISEMO1XhUxr+sLCfVK0bKd9RARpzOdXGWSRNiCtDj8f
	q7GpF6OhRkY5N162pV4hHB0iGO083Iwd/6tPOdGhYIkNlfNVnFPDVs+Z0aLa969FiHw1n83CDTA
	5Vdg4w2So9NFygkgdQtRfT+wvxv89dSjBfPDYWKK5FEo=
X-Google-Smtp-Source: AGHT+IH4WzCZIRsxDkQQbV4ooslyAXOnOnnFTkWKpM4k9PgSJygdHWtyWMUs2KYLkQMOoMS8IbvkQg==
X-Received: by 2002:a05:6a00:814:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-76ab2d5248bmr5203340b3a.12.1753892276985;
        Wed, 30 Jul 2025 09:17:56 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-7640ad06762sm11101766b3a.80.2025.07.30.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:17:56 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:17:55 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Remove unnecessary assignment to ret in
 nvmet_ns_enable()
Message-ID: <20250730161755.GA1177361-mkhalfella@purestorage.com>
References: <20250725230639.2017274-1-mkhalfella@purestorage.com>
 <20250730155335.GB19799@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730155335.GB19799@lst.de>

On 2025-07-30 17:53:35 +0200, Christoph Hellwig wrote:
> On Fri, Jul 25, 2025 at 04:06:39PM -0700, Mohamed Khalfella wrote:
> > Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> > moved checking maximum number of namespaces in subsystem from
> > nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
> > nvmet_ns_enable() is no longer needed, remove it.
> 
> This assignment already is gone in the current tree.
> 

Yep, it looks like it has been removed in commit 2e7dd5c1a8ae ("nvmet: remove
redundant assignment of error code in nvmet_ns_enable()").

Thanks,

