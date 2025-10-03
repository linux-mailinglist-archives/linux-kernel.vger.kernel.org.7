Return-Path: <linux-kernel+bounces-841239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1804BB696B
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7F844EBC04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631D2EBDC8;
	Fri,  3 Oct 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PWEaVRm2"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C9279DA1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493203; cv=none; b=Cl2+NeQ3HK7CAfrMqUaPQ2TylW3aqY+MW13TO1xxDFCTFQRxO5mt9oJOfWJMO1md+YArc1CTUc5zsxs2rbT3pW8v/eNtJcToP3gQd6Cals+oZNclNl3EySBqV1UzgjW6RDxkygQ0S/S1NgrlIR5rnnaOF7Zcj0dleIjlEKHVlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493203; c=relaxed/simple;
	bh=wSgcHRu4XVhLC13BBYF4OctryqDLWNhWswI6B3UGTCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLdo0TD1i79Gw/Sh7/qIqhydUjNq8I8NWVeDYgiu5YqBYwbvWbeegx7AZHiQbVtcdY3DYxYl5qyC6+hCHEPANZ2KlkzbPSxdY5NHsn6Q57gjJ0PtsBQEDkeW3ZcdibDk/4tszJveVtsXC2/nbX1lgF7eoJ1nOT46CDBiVq22jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PWEaVRm2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85e76e886a0so192887485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759493200; x=1760098000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSgcHRu4XVhLC13BBYF4OctryqDLWNhWswI6B3UGTCo=;
        b=PWEaVRm2l/bqBXatSPjD0pVs0Lid924vLnwvssIt2Zif2dfLuy9ykZyOesckpUe+U8
         nls4oiBmHl/E9KM4DbsLX7WUIXNvEUeJWMOPhbHSYyJ0uAz05mpbRhMVADuTufzowJDY
         5L/92m2ll2xQ+etp0PMZanea26e7dwrefolf9z00ILWbS7d6eKRO5bgppaJNPoKDOaao
         PiCLn2i/aEBHzjIISbFm4Ca77zuhzaBj4YamnJw5QqOLTeqEKW2KvK4hb7c58nLE2Z5b
         sv19Zp2E1QR/yX2+ckin0kVdUh1mRXUGvbRPrQNWeJBG/hzV31iR3SRTlKiQ3nq8IcSj
         XSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493200; x=1760098000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSgcHRu4XVhLC13BBYF4OctryqDLWNhWswI6B3UGTCo=;
        b=n4Emqzo8Dnp9G3Ml5CnLNc9KTtCkRvTCowt4hOFU8Sa6d91tJuJ5E1b7HXKRyeup0A
         WFiXQ0JsGQy7YrQXoNCraAAhsmafJGurJdHVzWJd8qTV/c8mNyakpNgDDjANwf+fWDJR
         fqtpkJxCI3YvXlEAjtbixMDJ85iMrhT7Ji8dKTvDFZwBt4YUZNSTbTZo3uj7WweRcfdz
         K0b8CEfaHva1OHKbzZzZ+4V3Sari/JWPmaZ3gYS6Si0oDTNZPuU10C0i+hRoiE8WKAKn
         EV15ceaaFNQ00olVPQ6/QzEV3HNWgPp5/aCHtkBS7JvkSVeAw44gzyT/3bZcILlp7WEH
         nGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX97Yctm+vNryrgW4FXI0V25JVL74PZ1tqIV2on7KMtBAYguyeNlGCLswwg5eFyob1u5qRAkYcpj4ku9M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KgvkS37/X3JH5WgrNPL0HnQ4rKpqgOXtpx14hjpCiIRIrTto
	cqgJpaaiBrd2e6/jqt1k9Gsi/sAJ6AeI65H6P1dfu7SDrfNfr3rWjDSGl3wQ8N7GpcM=
X-Gm-Gg: ASbGnctWrCHkDNIbu/laFtXYQnZYRGIE7F3rIchvmXAFilChy2N+wYAnIl4KyWoKGyp
	1sJuzImbONQOYhDDmAV0jjYl7bIR0ibeVJcpFkwPJYKAfNjUsmqmTg1iHwReg7fk6ebQxmDaP2O
	iOqYiq+ACYvRG6jmjhalahmaTrNvTnkvErs9U+zUoVlgDfEJw7irAYrEsVZFU3msE3+eTr3fbC7
	tAlsMfXje/6rs3u3u6RQ24uWQrQ/NXC//sqi4DeGZdWdBLWOpo/rypZ1H8tKzHvV4jialdTpihw
	yydQ1fu++DDtbkqAwFOXIUVAT1ApahD/dSGNpDp36xl+uBijVDc3Z71QB9ZxzAw9b7qiXR2KEp8
	7fUXDbWR1mzu1dRIs16H6hpI/z2UF4kC1GXEjSqJBZShD/jHod+PO6kLpUEG9MprfYsrOOTmzdP
	fjvJ2T2217obakVHh0H33j5njqCU+56HowQ5skwg==
X-Google-Smtp-Source: AGHT+IESD9NWxfSord5jCIA31803QVCClkT5xpnqBbd7V15YYn81ihEL+4lu2i2UsZSEnmpQdxOuRg==
X-Received: by 2002:a05:620a:2893:b0:85b:be19:653 with SMTP id af79cd13be357-87a39a943c0mr330432485a.84.1759493200373;
        Fri, 03 Oct 2025 05:06:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772836c1csm407328385a.28.2025.10.03.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:06:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4eYY-0000000E4oO-3XXT;
	Fri, 03 Oct 2025 09:06:38 -0300
Date: Fri, 3 Oct 2025 09:06:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20251003120638.GM3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
 <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca>
 <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:24:59PM -0700, Chris Li wrote:

> As David pointed out in the other email, the PCI also supports other
> non vfio PCI devices which do not have the FD and FD related sessions.
> That is the original intent for the LUO PCI subsystem.

This doesn't make sense. We don't know how to solve this problem yet,
but I'm pretty confident we will need to inject a FD and session into
these drivers too.

> away once we have the vfio-pci as the real user. Actually getting the
> pci-pf-stub driver working would be a smaller and reasonable step to
> justify the PF support in LUO PCI.

In this contex pci-pf-stub is useless, just use vfio-pci as the SRIOV
stub. I wouldn't invest in it. Especially since it creates more
complexity because we don't have an obvious way to get the session FD.

Jason

