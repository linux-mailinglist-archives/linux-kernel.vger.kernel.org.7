Return-Path: <linux-kernel+bounces-820684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2CB7DE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45FD168B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB91F09A5;
	Wed, 17 Sep 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g7zdV7WO"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73F13B7A3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112566; cv=none; b=mlTSo/CchbxnSCZYEi8DrsiLQJ9reVT4b0FFv6rGHYuhJmp7nQeLhag++VvgKBJ+uZZwurDJDdFM/fcudpfUpE+JvfxyzSk4c+H+gchuEXMCOFzfiQZgDXaktVhi/nQiXoGgOQJUdejN6CTgBLziN5kGZB8MhJrdURSsVmD2/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112566; c=relaxed/simple;
	bh=vh4D3lz4qinchk1hC/kj6LCnkyHCrjcf/nEQajAoip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7O3jPPPnLrxi3D6Wf9oWc+R0Qcvl+CC3cyetyQtQgr2m0wfnr/mVRn/tN4h69rqv0/nucq7kQV35hKvuN+AM+MtZ04o9rN5BvTF9euiP4jU66xR1dL2UiAMWTVe0Pq5HFkI7/4SgBaxNsdaenogexGWopnVrR0hLSHFwBK38w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g7zdV7WO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b61161c35cso76196061cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758112564; x=1758717364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vh4D3lz4qinchk1hC/kj6LCnkyHCrjcf/nEQajAoip8=;
        b=g7zdV7WOHFDVvS9+Ev8qudlXJnVA6XlMcNuqfKWldrPQdc6rrsgH9O5HmmtPMaohMz
         u+plorN92eiYy7KaAjj5qNgMB0gs2bOMob43GXcBgYTIi9P3TW1YCbx2Nd/roXIQZ3Ik
         nN0tvK0jaX80bFnOeKXH6QRkoYvuoaCf2JtfTksdis0jUEP49trxESOr9IZzctmWBLGa
         XnJIVSZBo708k2J0WKInU/FL6jdje2awyRjhB9CBVWHjZiwdBvu4GFM3cON4Oy9n5e+0
         9KV4mA1s3thZui3CuJ325QBtzpVduV/rNussvZUrJreH3CBPJLjhlZCq8GMzpPgQLJ/3
         lskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112564; x=1758717364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh4D3lz4qinchk1hC/kj6LCnkyHCrjcf/nEQajAoip8=;
        b=cmbUupWxTZtKuOlZySUavPirwbqc31lQGsNMuLuOdc1QpbIorNSHpiiBdTbxUpRSG3
         nMRzk4fHsoLJ639zVPrVWfTgJhHnH+tGFoAqaDb1UOTBJz4u2WkEflaXaHo074nohL+W
         ha2+e0uDgWEot2lcfROFIO6mEs0hSRsvD0vioogTbtF3u4WCb21NohHpsYWxIUuvgE1A
         3KCwnipBh5NMenx9bXtjtzux2lmBMngVGskOAhyUJiC0DVFSUMKnfquq57NAw2/yo+kg
         rlT0M63Q8bBk3jSfrvhZdv70U+UuknCZLQ0Pc86rY8hsQxrrdpdSkm3HNxtLw0Ng8QoN
         Vbmw==
X-Forwarded-Encrypted: i=1; AJvYcCXryL8qmahNLJDzeHrKzOoDY2z5fZgIsXjht6RQZOOXF6FQDDvlDY/SpmH4saavMQ9/ixxjB4EgWtxgtQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoBq3bOf8Msu6FpE35dhYWD6ij0IicN76XvVlesgRn6MSKtS3
	hlywU7cgWC5aica02cm5HOFyaEt3oeBbfUnw+yskgdTndROl1LGwldp99wTOW/momBc32Wqj7X3
	Vxk2a
X-Gm-Gg: ASbGnctELiuund2MFgciFKGm+9B2WM26b4A0L6LJkcwKgOzCV82aGdJ/E1vqvOfbRw/
	IshjdBVSUKONKOF3rBJkAn2f0IZPKP2Z93PeOeh9CfjakYLitpwkFwy6Eq/ylxBH5mdhw5Ny29B
	OhLxbw9yQkHKBoYjWlQ54QgqVyQzMSWxrKYSpWHJ6+X09JapEK4UyrQGlX8MP56YF6HH4pp3V2u
	VcWOy5J8FrE+wp4Dc7Joc3qJRrlvO+73U7hAEe7vSGN4T4wWHia5i0/AwdMm7WIBnJJ3Acmb0gY
	5S/KyW1B/9f0GRryr/QIs85bIM3V8DHO2K7IfCxKWDIDRTNKhXtFWOMbCiP/FGSPGRUoOhE/
X-Google-Smtp-Source: AGHT+IEGvkvScyo54tTHL6/SrnC/aHIWG/EkopD8ichGedBCY62w/oSm7uSdoqmasg8xw4ohjLSyZw==
X-Received: by 2002:a05:622a:4:b0:4b6:2ca5:2035 with SMTP id d75a77b69052e-4ba6c6b4280mr24104781cf.81.1758112563531;
        Wed, 17 Sep 2025 05:36:03 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7af2426a3sm34649061cf.37.2025.09.17.05.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:36:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyrOD-00000005jqq-480E;
	Wed, 17 Sep 2025 09:36:01 -0300
Date: Wed, 17 Sep 2025 09:36:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250917123601.GA1326709@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMl_5j8G3IGulAC6@google.com>

On Tue, Sep 16, 2025 at 03:19:02PM +0000, Mostafa Saleh wrote:

> I think the fix for the problem Will mentioned is to just use CMOs
> before accessing the host structures, so that should be simple.
> If it turns to be more complicated, I am happy to drop the support
> for non-coherent devices from this series and we can add it later.

I feel like it is easier/better to fix the driver to use cachable
memory than to add CMOs to the pkvm side..

This way it will help qemu/etc as well.

Jason

