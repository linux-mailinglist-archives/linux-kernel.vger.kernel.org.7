Return-Path: <linux-kernel+bounces-814314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128BDB55251
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8086ABA255E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56C3128C8;
	Fri, 12 Sep 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVsLrQfF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82430E0E7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688648; cv=none; b=FOpsCN8ygrAu7R6VfaIunsttC8rhMmz17/XVPLTFwEzzEQX//SHRJgRyi3UayIF7LDUleVXk+diITjLWi3Nm54tYXr1Uk+IkPIZ0J094oEuecEUsGk8pJKkdURuUIwxbG2YrRMIWeGfANuqwYG36sheGQ+I18MNvAGcJgNMt4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688648; c=relaxed/simple;
	bh=nsgqBhuQMIRgj0Foq7lbTZgCUyn2NDAcRteObcMHZAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSrMETi3FL26y0pARExs5ZHslRmbm4pkQ7PqGbnxHGprhS0pksfm5jDnWI3QWPpiCnifKa/Vj7oTuoioMMdwImiu1gt7z8y/jJuF3EVQns/F4Lkl/mQYy+YK5hH/GVvL/FtGqsja7pdGW7WwgMTXD34t5nGImjp5DaB/VBrQc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVsLrQfF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757688645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWnv1uPYTna1ts6VTb5bmSJ4gFzt0Uz75RWyORHBYho=;
	b=NVsLrQfFJ7gcWGfmrp65i56c+GovdvJArTUz3ysX887vX+Swj+RCOiHILo3ZAsDpyz8c4e
	AhsHaqwkfI2whgS2tVdKPqWXDu31eEuFMkxRxoNwByeBADLi8guOJenj9FtF7i0Cj1bDi7
	eS+n8aYMknGy8L5K+9C/HrpUMJp7ht4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-lQsiPFy3PSSOq9IPvtf7sg-1; Fri, 12 Sep 2025 10:50:44 -0400
X-MC-Unique: lQsiPFy3PSSOq9IPvtf7sg-1
X-Mimecast-MFC-AGG-ID: lQsiPFy3PSSOq9IPvtf7sg_1757688643
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b548745115so51515371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688643; x=1758293443;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWnv1uPYTna1ts6VTb5bmSJ4gFzt0Uz75RWyORHBYho=;
        b=wPh0j9tNfVgIk1CJNOSniq1BTGsw8MM2843v5Ut+D/GMYR52sPietfcTz81rONWT0Q
         /26Fq4N0nG4mvf088IP5WaHWGzFc5AeD++yqhGH9jxekpMrzHGW/RnEpwl+HsKuYwX/X
         h8xokTbpv5iW1RW67aYKtzSTNqmpVH54i5iJDBKFI7/pp3hYDGRNIpEdDD1/g2E6TcRv
         8p+sQEecrj6CF0tOSqITu6GIoqXm8hrJNPBGkOqrvBMJ87oxXpg9bJni1as63CtO5OZZ
         c+/vraqBv3FOn+3hukVXA4B14cd3W4xIJ4jSpKU3qXtLAdCci30OuGZptWl+vExazpP0
         WCqg==
X-Forwarded-Encrypted: i=1; AJvYcCXDth/gJjnwU+BPtdCWxeZEgviVURo9rE0aVMXKA/2TS6ZmfSDrDWQVeRukhbK/yF1ZmlWg8Vlbo36l3Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9imjBuDsFtM/K0fddneI8DXgCXOTGz+JrGq5bPABx6jDTlFRU
	FpWRiRs95PH/Ix5o68ZM0nhNDDSYN1Fth01hAmy1NAG8Li9eSjsO8Zb9Lgfjm/QFhVtfNI052k1
	VACS6teU6KVk8bMeCNi0uRS5O0eCM42PlEanFWiYdBMVXWR6BOXzrZ7dVvjMqX26GEQ==
X-Gm-Gg: ASbGncuprQkzgJv/by/PZ0b4A9iveKk7NTIGEEuTQkTb2piLiEXySOh1oXykSt0vv33
	qhPqxDVTsn9phL+eVVFX34796quHk7wkNFF4/HLJP3G/X/A8so+7pta43eidHoBWiltfx+yMiA5
	cB03JWsd2RAkVpe5ARqKPzb4P1IQo6gsZQ1324bXX1qZ+hFiaYKgrK+xV6zQuZC+9burU0dM+gM
	cMNVtdnQvjfvCEUgNCAYBRhzJioUUzryaryYE0ZqquRpRUiWjWZxYkFbVzXiDdp5ESeK+YRqu5p
	B7lgPZheNWqkrq0C6MAQv9UBYEOYdQoUkQivmKFKv0k1kxvEPduTMgSjefPunIGXmFffW91790W
	lF9MzJXKVWvXFFs9fNRHWerRoVpe8Rw==
X-Received: by 2002:a05:622a:5c1a:b0:4a7:81f6:331e with SMTP id d75a77b69052e-4b77cb3caa7mr40317831cf.6.1757688642702;
        Fri, 12 Sep 2025 07:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyVIdYLjBKhorz3T0zQ9Rxegov6rF9Te/Pu4Zg+RAzt3WZQiqnmCsJB1uwM7uqun0gGUSs7Q==
X-Received: by 2002:a05:622a:5c1a:b0:4a7:81f6:331e with SMTP id d75a77b69052e-4b77cb3caa7mr40317551cf.6.1757688642278;
        Fri, 12 Sep 2025 07:50:42 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639a61502sm26238491cf.0.2025.09.12.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:50:41 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:50:39 -0400
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
Subject: Re: [PATCH v3 4/5] clk: Add KUnit tests for assigned-clock-sscs
Message-ID: <aMQzP7DamsQWl8_L@redhat.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
 <20250912-clk-ssc-version1-v3-4-fd1e07476ba1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-clk-ssc-version1-v3-4-fd1e07476ba1@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 12, 2025 at 11:35:53AM +0800, Peng Fan wrote:
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
> ---

There's no need to add a Co-developed-by for me. I just gave you a very
rough starting point.

> diff --git a/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
> index 1d964672e8553a90263af400367a2d947f755015..d62c7522c92461245d45f8ac0ebd26fa2850be98 100644
> --- a/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
> +++ b/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
> @@ -12,5 +12,6 @@ kunit-clock-consumer {
>  		compatible = "test,clk-consumer";
>  		assigned-clocks = <&clk>;
>  		assigned-clock-rates = <0>;
> +		assigned-clock-sscs = <0 0 0>;
>  	};
>  };

kunit_clk_assigned_rates_zero_consumer.dtso is modified, however
kunit_clk_assigned_rates_zero.dtso was not. The underlying test doesn't
check for this, so you can drop the change to this dtso file.

Everything else looks good to me.

Brian


