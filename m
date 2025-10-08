Return-Path: <linux-kernel+bounces-845395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A1BC4B80
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1553C6BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD082F8BD9;
	Wed,  8 Oct 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIxS5sHy"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069512F7AB0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925442; cv=none; b=Eq4I3yL6r4xhITvaOGzGiKh6i4SUf2mQasZmlIUekfENEesVRbCOYmmnR4K/wR+iARXeee1h+olXfh9yhl9OATaTYfMdA7dXEc7nr/izfcGpD2fEfLsGjKnldhqWT0rzNS3inP2foZCAWWcQ/NnhKqvGvxMUM2No29XbffQZGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925442; c=relaxed/simple;
	bh=ExZT4k3C16MHTzL11cJYoXce3m05zUuM3xNa/2Qjl/U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVXCxwE1hfaSfmDbZ7Cn27aCcqP9oE/nbrN8D4KqunfvOn0jP7qg+IPdAK/DDUyeob+tf78L2DQ7Q8vbcNLZQiWkaTTtkYL0oXk1rcxm89Rg6ofLzLCQR29RRiax6FtLfVc1KvfnGVbtxQNhoUXE04BXaYfgunJj25kfgSsvs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIxS5sHy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5818de29d15so9014668e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759925439; x=1760530239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLqC1bH/0EiKXqmcXDwHomuoVPXgIMZQ6QzLjCzbq4E=;
        b=eIxS5sHy+KxMb33guVfNNt8Svr2K+ipPuOZNHQnfMIYTEmrHfMTwP/L2Wco6dV7Zai
         EnPoutni4GoJb8tGnJ8ynVZ8sTO4SbN+FIjfSwZVwCb89qT6Wlpxr5dBzEY26XEXk69S
         rtb61BUQROEczW1xo+GhQusrisO5VSmFvHDXBvE5KfcnFH1f6vGgNZp+BwbVMprXtbyr
         //2Q71bAQeb+8S1YMWF777AJn9QyLE/+XWDbMVo9V1NVdgEzelMIkcpziooLCgc9R/zV
         mt2CbFw0IgWSKES/4rECZvrcXLI/yaW1LvUl+4jD9/QsWwyOZPFMAkXtHJ3w25/pXGrX
         3HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925439; x=1760530239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLqC1bH/0EiKXqmcXDwHomuoVPXgIMZQ6QzLjCzbq4E=;
        b=gzV1OisW7/gUUgEy7aP5GyJT7j+cJG5uzzQ90R/lZ7Adw+rnGpbfSn+rGTRlIKbniK
         9ArcFW/C+5KKMKXW7Td2iwyNnv2g7kZb/r7poec0gV8YPKSMUV0KMSqD7UkZW4xWKdEd
         ROAWRVjKfye6Uzr9FpvtiqSAEYGk7fG4bJImH2DKxOUAXV/YqsFmZEITMb3rMV39qecN
         MZ3c2RMn9hs2PpZ5002FM0vhboAGqeBnVCzpn/QjHQQkLCOGfnJJCbWe5Xk7YlYUP0dg
         qoBX67lDY4UmwVqVbWcXrOqtTvC9goLz9uFd1DlAj/2r7eiAAyh8wsUZF3LXN0boAaTM
         LDyg==
X-Forwarded-Encrypted: i=1; AJvYcCXouRQYNZ1i/IfKXVnqHk62j3hm0DZ6e2RSeK3x0N0WozssySo/9Y4YARQe9l9gZFTAo4TxL7/7aTq6Jxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeP0U2xOYA6rY/qY2wFP+NbJyqW7EmpIVzyHFcd4I4cMf/qrg3
	M6eVtpXsbyvy4J2a+ZlIBycWDAT3V8ai0CMaQetpkdMDjpMOb/+5CQmq
X-Gm-Gg: ASbGncv9mc+swCNkaeTQh/nrfPfTWZAct/eGiu5lV76SlGz3YzxdwmOFJ7ZJeeqzTke
	KeTfJXUqw7gP2o1CIV9jjUALEFAsZ+sZTQfChVhBeQmUZG0F2slonwmuPmyG80Kv48VcLNwNfzr
	a/Li8TCmjmHRR8L5WXPyPANvtK5/HOGgYzeQIG5zJOP6Pp9CPKeCDR8SzKePDA9YABRhzY6n9Ao
	+AmK5ptD91dcaSzEA5ECtMO7+RhzX1mpDK6dYOPTfMpFkDwapxdMXW8MMdVlE0FJDxfotw+Xxku
	+rkciYOyR89AsPt9hUuVecddBKRoQz7GUBfSlU/8PvW2OpOJN963nEiF3VcbgdefWv3G22QncOj
	AnJDrA2IHI/OFrLPlqLZ99xB8
X-Google-Smtp-Source: AGHT+IHnyil3xOIk69WD0FQndQ4jJPTW24dHVnbTdsvNDUjPd/vaXJ7RrAz1O6UkOunwyqcfMbvcoQ==
X-Received: by 2002:a05:6512:3c9c:b0:58a:9251:4013 with SMTP id 2adb3069b0e04-5906de8ff00mr1126261e87.51.1759925438712;
        Wed, 08 Oct 2025 05:10:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59067823d9esm1386992e87.69.2025.10.08.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:10:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 8 Oct 2025 14:10:36 +0200
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] __vmalloc()/kvmalloc() and no-block support(v4)
Message-ID: <aOZUvDxuTqCYlLx2@milan>
References: <20251007122035.56347-1-urezki@gmail.com>
 <20251007143126.451f73cae2d3d7f5a36e4229@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007143126.451f73cae2d3d7f5a36e4229@linux-foundation.org>

On Tue, Oct 07, 2025 at 02:31:26PM -0700, Andrew Morton wrote:
> On Tue,  7 Oct 2025 14:20:25 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > This is v4. It is based on the next-20250929 branch. I am pretty done
> > with it, if no objections, appreciate if it is taken.
> > 
> > https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
> > https://lkml.org/lkml/2025/8/7/332
> > https://lore.kernel.org/all/20251001192647.195204-1-urezki@gmail.com/
> 
> It would be nice (and conventional) to have a [0/N]
> introduction/overview, please.  I went back through the previous
> iterations and could have kind of used
> https://lkml.org/lkml/2025/8/7/332, but that doesn't look very
> applicable.
> 
OK, next time i will numerate links so it is easier to keep track of it.

Thank you!

--
Uladzislau Rezki

