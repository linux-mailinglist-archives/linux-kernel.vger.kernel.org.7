Return-Path: <linux-kernel+bounces-816943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FDAB57B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37BC3BA708
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794730496B;
	Mon, 15 Sep 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxVbyryh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF630149E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939394; cv=none; b=Qp62UEleSPqSOX3HL3BX5CKOnblrCUcfxR80pA8somfMB620OzvYghUucMfi+NyZQeMtf0uJeFYQdfiJng5aUjH0VMhHnfcIv0AYNWILrSHnZfY9qzCCQ1x7pJkPUHb6yfG1jifBwW79KkncuxpfUTy5C8/eB2RFA8y3DO2kCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939394; c=relaxed/simple;
	bh=gpLksYcw9Myqwzil/WQeDaXG00Vp4w5WqIhVKKBj/rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHlTJTDFojmciysjILST0Uu9+qqShQtQaZ0DKsGJbE/LuF0I/fEZwu0UPTQ1mYRtwueWjd9G10Yx/4Vlsr3LpmWOIys90U5NPqZhgpxnm85nnpTvlOCNiArgFBMOfY8SnmKOhrXxohbK1i4k0OYi5wk6eTeiPcbxOEK6s8I4ezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxVbyryh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757939391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wLL8rzXBaL9TL+cKj7734rcnA0rGbpZjb3H9q3ePb+M=;
	b=BxVbyryhWp089TG+BJWn0h2VhChtvXd2X+QpxpU4vILt7kZoA5uen1IKSuDSor6HLu8qNE
	a2IqBegL6tJR1B4rI3cxt/vIANKDDwIgsf67jKa+ncngPS9WaLGTmApuTMsNvQlsPb3/jI
	33W/2KELGMr0dm7F16KeU8n2QUO5eNQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Wd5uXb_6O4mfDZ7DNiFsBQ-1; Mon, 15 Sep 2025 08:29:50 -0400
X-MC-Unique: Wd5uXb_6O4mfDZ7DNiFsBQ-1
X-Mimecast-MFC-AGG-ID: Wd5uXb_6O4mfDZ7DNiFsBQ_1757939389
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82119c68f9bso1362438785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939389; x=1758544189;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLL8rzXBaL9TL+cKj7734rcnA0rGbpZjb3H9q3ePb+M=;
        b=nlqUqdUDrROx/Yu829iLg/OV3YoMa+OmHeVni/L2PSZhO2T5sizdOj+XZ5Jj+07oxn
         l5amTIwvinTp83W5PIEhfs/gcKjvGXHnXgKr92wizHzDi3TUTLKS70KdqSBwz+MK1mRc
         oy1iweWJp7xQ/7sNtYETmTI11SbM1eDVCgTzUzaifkeZyp0IqQ3z5ZqcfMSOB6PZybAB
         H2N8CNydQE9b5w/jf1H54lLdZTM9vQBOJ6d6xZFJGxule1nArWoNpljUlSEFgxFgxdy4
         3PHCMzBpNJtDZngmThwm3VPa6YcI6Vj9s6FOYBmsSisW8FJAdOtnNCIxbAqML9hAdyCH
         /GCg==
X-Forwarded-Encrypted: i=1; AJvYcCXXcpjUsIy0ezjBf49t+NCdH/RtdB7tObrWZd76LmeCniRoa6S9Xatk18A+ANKLPvQBtp7QmakrVnQIvt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZKlVshnJZPyX3Zb6Kqa2VadqY6XIeBo1V5htfHwyRQMK0OBj
	Z/Haw2PTjzdaYfTdzu5irAEDfSEYXcOgthVpxCGV0pe7uWA8KF0YXydS0eFlIZADceJdTrbA/HY
	F/FMHdW4JueDcl9wxQiko5Ovz60gGQzedhsP3aAtKe3tON1Tvn+ArsOl4ZiyoBYmVhA==
X-Gm-Gg: ASbGnct8Z9JrN5KvndLAk8CPvfmACvyoYVlKO09NHoxKHcpd1vaTWMOZkNWXl+LRn9e
	XADYgy1OzHbA91fNmwKOFvMLOQrguwb4u0issPfUbfK6qG2ZYAO+Fdu/srzqswnNghqK70rmPO+
	UjrWB8KJfIBbteZOA143TuMq6xxgHnV0H2yAzoG1Khb+1WnQmVtDaoxqI+ngg7sTDh38/SkhVNf
	qJvPtFLv0d1NgLdPz+1erdKQdHrcEoaL4pvjUAKEmy9Q3s866O4L+9U3o1ZmiXzdFUDhnbqv6XV
	FC6OYDK2weLdYMQwoPIIXeaUbjqHBDG/i5A0NQeVAtlzR3108DRIkfuGoktbj5WKFSkWVaTWBzI
	FhYLZ5BQKc+0BhgG2rMy7F7K5wRApR4E=
X-Received: by 2002:a05:620a:3194:b0:7f9:7000:f7bb with SMTP id af79cd13be357-823fbde9118mr1346855085a.7.1757939389157;
        Mon, 15 Sep 2025 05:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY7Mxjz8VG1qTosAk9YY8DjG+y2q7MXDw84ZmcJWfZt1ziy/I8az1raMUNBU225CmbUCJKNA==
X-Received: by 2002:a05:620a:3194:b0:7f9:7000:f7bb with SMTP id af79cd13be357-823fbde9118mr1346851185a.7.1757939388265;
        Mon, 15 Sep 2025 05:29:48 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b79a7b639esm26809461cf.5.2025.09.15.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:29:47 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:29:44 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] clk: Add KUnit tests for assigned-clock-sscs
Message-ID: <aMgGuDxzYZpw9sti@redhat.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-4-5a2cee2f0351@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-clk-ssc-version1-v4-4-5a2cee2f0351@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Sep 15, 2025 at 04:29:38PM +0800, Peng Fan wrote:
> Spread spectrum configuration is part of clock frequency settings,
> and its behavior can be validated similarly to assigned clock rates.
> 
> Extend the existing KUnit tests for assigned-clock-rates to cover
> assigned-clock-sscs by reusing the test framework. Add new test
> device trees:
>   - kunit_clk_assigned_sscs_null.dtso
>   - kunit_clk_assigned_sscs_null_consumer.dtso
>   - kunit_clk_assigned_sscs_without.dtso
>   - kunit_clk_assigned_sscs_without_consumer.dtso
>   - kunit_clk_assigned_sscs_zero.dtso
>   - kunit_clk_assigned_sscs_zero_consumer.dtso
> 
> These tests cover various invalid configurations of assigned-clock-sscs,
> ensuring robustness and consistent error handling, similar to the coverage
> provided for assigned-clock-rates.
> 
> Co-developed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This looks good to me. I'd typically leave a Reviewed-by, but that's
probably not appropriate since I'm already listed with a
Co-developed-by.

Brian


