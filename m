Return-Path: <linux-kernel+bounces-814341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD70B552A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B2758694F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20975221D87;
	Fri, 12 Sep 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7dwPCXD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192831FBEAC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689467; cv=none; b=XEGkOBtd8PQKhKbC9mmFaen+r4oUkwuxyMx6pBaQlPnmrSOi9zKkVqMN9yY7SUl7ra1bFIaROXMxVJ3uhX4o2aNwyRV02AZ8p299b+7psbdV3tG8ymVeqK1AIQW5ha/tpyaL1Ze74jJLnVQ74zAp5aeZ/C4+az+Np2KI5cEL7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689467; c=relaxed/simple;
	bh=2U3DqoOB9c4gUI0P2Jy+1Db4qAN8DMTnVvxyqVJIm5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWk1OYVzieJsBXcdUmq2puQPuspgutNByl4TPNWp+w7YH69XZhVYlD33Z1H004s7VViPCwILNE9OnCjOJaVNu9n5bHDh/YDUxKLUQtNkAtpVL2wtT6DxCgWhwRFyk4skq4HnBzjFv+QCMe7apJqswJBfbknh928FVgUSX0hE6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7dwPCXD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757689464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6+03+6KMi0xIZ+CNaQJK/sgah2Ln0Cdnhj4ONcK25Q=;
	b=Q7dwPCXD32SNxY4PMSZZE7idX6jNZ+stio1bdtlkoP9AvIeMXv1HwJS3cBYE8SqUUsHWu+
	o2OU7cANAFaPueRnm2/KGT29ExP0dzv092ht0CPVSZ6emq77K/whB3n72pl/tdQb8nDC94
	XCL3TrCOL1py/JcZpvk0N6hdTDNs06M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-mBZMYqS-PVqTqlzCChaDdw-1; Fri, 12 Sep 2025 11:04:23 -0400
X-MC-Unique: mBZMYqS-PVqTqlzCChaDdw-1
X-Mimecast-MFC-AGG-ID: mBZMYqS-PVqTqlzCChaDdw_1757689463
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8217df6d44cso337428785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689463; x=1758294263;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6+03+6KMi0xIZ+CNaQJK/sgah2Ln0Cdnhj4ONcK25Q=;
        b=pyQbswvufjkrXAdpTca2mJrW8ax6BMyslQwMYNeiIJA3geoQlo2buPXtCAZW4J9yNL
         TtH2gmrlvlP+GE2q1SJ/ntvsSF+ZJFh0Q0l0sPodjNTWxX8HXthGCTJpMCjca6bj+0i7
         amrd9cpEvUxRrpxZDEPMEp0aPcA6KOLjQ7y/nOOmahMIHdbN3X6pPVY73yiJGSv35YcU
         jeFUqqynm01WF9J0pxWFAk9DHW/2AAJp4LA35sGuxkTfV+bhjxheuxQu/CjAsJ0caNFd
         HPsZEI7nA/krtKIO7j9wb3QckyIm0h2eWnhxYwJ50X30EJf+8xBcMasvcVEEwYrnMdUH
         oymw==
X-Forwarded-Encrypted: i=1; AJvYcCXMYO9omXxrqp01yR7PM0nNVVZjsDsah/XLZKSrbsYCMxN/woV1XC/wRjwo45KnobjXOu4EcOJC4l+Wcc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKB1TFhx/7kU7bFst4Fkctx0BbA7hjcfuLMI3S6iPXNLWjNCoA
	+K4YY+pg4+ZMt+ATwFxWakaYp12E838ZZGO05GO/hqcTWCOXRmJPCrpuA0D9bKcTVOX1daNmoCj
	Hj4bE5gFxdyVO4Y58SwNH/WW8pvXVX24FFKDCtkFxb0zhlZwyMgbdkgWsxVYcfQsQ4A==
X-Gm-Gg: ASbGncsIanbZrT+pep9jFonJQ2lznd9LnBevi4UcYXMc4sloRu69ARHbpkOnWjRcmMH
	uMmbwo7jH6zLUlni47xkqFOJjyw/EECId1efy/b+NCaCW0/ClSRP0Ws7+wY5CiaLttaW0lOTJI+
	CPJDd2+gHf8xqohhJFmzjQVA9Pjo1XDdM1awGxUfP0EsiM2Su8hyUiv9G/osOyFoWF+ir6uyurM
	nXkzsa31dsUY4Sswte1/QS1FEIETZLPNW3hUaexC9oPz8ZEcXoYJcKfoTAg6k936Kyu+EXMQ68f
	IgJ2Z48HvE7u8y+O1PZFJ1LYe20SWicg6NcnczfXZ06D29XpmCxQogP6eyWIGquJHOQS/hgJ320
	wgidFAugzaThhpQh3G3PiOUBuBfBfEg==
X-Received: by 2002:a05:620a:28c4:b0:810:bba9:d089 with SMTP id af79cd13be357-823fc987678mr477701385a.32.1757689452927;
        Fri, 12 Sep 2025 08:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEgtgh/Gg0WuKmmKqdI04apG8y63BvE/4WJYY0ss9G0WLraw6KPsoUpne6BKqb/M/2Jd8L2w==
X-Received: by 2002:a05:620a:28c4:b0:810:bba9:d089 with SMTP id af79cd13be357-823fc987678mr477601585a.32.1757689446310;
        Fri, 12 Sep 2025 08:04:06 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd704b90sm283525285a.43.2025.09.12.08.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:04:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:04:02 -0400
From: Brian Masney <bmasney@redhat.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dt-bindings: clock: st: flexgen: remove
 deprecated compatibles
Message-ID: <aMQ2Ym1GL3ZbyAOI@redhat.com>
References: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
 <20250912-master-v2-5-2c0b1b891c20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-master-v2-5-2c0b1b891c20@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 12, 2025 at 01:36:12PM +0200, Raphael Gallais-Pou wrote:
> st/stih407-clock.dtsi file has been removed in commit 65322c1daf51
> ("clk: st: flexgen: remove unused compatible").  This file has three
> compatibles which are now dangling.  Remove them from documentation.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


