Return-Path: <linux-kernel+bounces-841051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6DBB6232
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D989C487796
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326622D4DD;
	Fri,  3 Oct 2025 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LkYpphNw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD90227EA4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475242; cv=none; b=ZzG+ypC3pUn9V27w21Vo8DppNDEXfNIGvU5+pwoo+c3gg2HnluLFShcxGIbWWXiTxD/E1IynKaDnvl7h7lsCM6ETmtlXZQkHotq4sv4k7q/TxIYq11CAlCnal/ULNY2ZN7ewnxUtCQs1gHx1+lfP42mvBGvV5keB4/nDBYevq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475242; c=relaxed/simple;
	bh=NmBarXdprph0Ea9BqhLbnDit9HvUdKIbTKXdxSGKLqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR8yQCkHX3VXE5hq69ofnAe+yMsnE+Cj+dlq8Z9Fj5xH03z1LqRjQyJKKimRFm2/6HAaNzB/8GDR9o3Hsd1U/SOcJW/p8o+IToq9uvToQ6kh+kCWSv1HtVeifqLqM9uWwfNcIOPW3G4KcEqDNLmO1MgLyjE/0WV5ftKZI+tYpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LkYpphNw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b484b15e72bso36070166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759475238; x=1760080038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oJsClXNUdjNS3IHTnmCIDO3oNqk4uGp8NgO3dHySVY=;
        b=LkYpphNwNAbETbOGIbWmZZmyFtUGSOAp8LMFKwpGi26mMwVb/d3IrhjMm7Ri4/kKga
         uI3rNze6Ff8rgVzc/fkSrjaSxAluUQR7MiZnrGn6i8r+PTq/ugw2vbIrAqHE8DtZuuMz
         uVN16AaShzAccnaEqkHsX8wi8Ja7PZhlvD0L7pJf/UReWlSJciGzg06mwNFqGHgkwEkJ
         fhlYuH/hIo3BgPihv8DmkslEROtIDD1jL/VxO614CoPYLsRIg3LX1mVLqVMQwVuQl8iw
         qraFs1oA3iv57UGvDvLwj/cRSygsh5O9ZBhvx1e9fjB74TsPN/j0rKMotE9z7YDzwzmC
         s+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475238; x=1760080038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oJsClXNUdjNS3IHTnmCIDO3oNqk4uGp8NgO3dHySVY=;
        b=JewoJ8B3XiVahNS01i3mEGWNDD+l6Sd7mxSGFyS7eW4iL/6Qj2gTYWTr4jWTSesMgD
         hmh5NEX6wWrPb7KpQjwyZMu8AZXqflJ6DXAOPtHMVLdZEEGSajYUuml+zSNsi70itUej
         jE/IXtZ2U718yEQMDGpiq8yM65jwFqx+upjaN8TBIxVlKtG4DqUlFH1GAIwNeXUWs5Yj
         aR4Z+ODaFtl491VM+qZDyHyqtTaTR1ZW8qB1bUSGGwS3tJqdA9MaM+pbkmbQnmXv4EG6
         6hEDq/WWJ/+XIwDAUVIGkgk/zEs8pc6da4qaGjeucyOeX+vm2CJmDZrnmh7Pz7TcMNRy
         UkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Zsb0nTAXdzrMVzwe4WMt/HjU2fsdjCWRc7EXM/vZG4eSEn4+aWSBBDh39s3Y2Ob87yKX/oK/+7qhk2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5R3ieHY7t360e13j2hCXuWXe7kZELYKzCLVlVk+vf9VdgVMN
	4ztOeKl85boXsvYeYu+vbHOQyehoPNKNnJP7Y0bebydDgQI/89cCiA7FSG/J2G2O2lo=
X-Gm-Gg: ASbGncuVrqJSkE432Zyxn2eSWUrY4MRqdSPcyrsG81K6s/lAcylyvHWmS4rr/laMoJt
	4hBGIxGx+8dU1Oqf37Oq9dWNzoZlHlwU3SGllzALehTRcqfAtgux+j9iy33WTK9JmJDPFUYYZXs
	jpaq4wZUl9Q+aUA3bvZOsmj3uNhe5BFUQhLcpSsuXcPucJhD7v+XcNroxlRaxXWqznkVvbPAihb
	5PK2G6jJCW+ZHShkqBrOebDQaSTwejvIjbxFjMyhrFzFT2tGDK3az9rSGd6L3TehXjqXBI4M9dk
	VaaKS1mwqsCyAmyjeMG5M6iLAUW24utWpuA2VYj4RAHlkrkVsJ3FnVMiRUGyjve6Brg7zPGnE7l
	g0B49WUeeF/kLc5rKBb3tmUYFnv029fs2P06lEhp/hCfy9n6RrYKSSvhB4LXFRgUmo6yX9o7XXu
	URN2HGGhIifbv8z7HtnHySXl32looafOhW/RAPrt/9Xcl7wXJYYwRh
X-Google-Smtp-Source: AGHT+IFHgcgAxKrBEwL/rl1KkiwB5iUsa34TbQ1eqD87gj7Bd+hJwtRTUeDPma+saazo3hj9xNIPCw==
X-Received: by 2002:a17:907:94c8:b0:b3d:6ec6:9e88 with SMTP id a640c23a62f3a-b49c295f869mr130567666b.7.1759475238345;
        Fri, 03 Oct 2025 00:07:18 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4d9f5sm375183666b.66.2025.10.03.00.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:07:18 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:07:08 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Robin Murphy
 <robin.murphy@arm.com>, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251003090708.7951d755@mordecai.tesarici.cz>
In-Reply-To: <9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
References: <CGME20251001061047eucas1p1f96a848ff2643b48179dd3e55959da7e@eucas1p1.samsung.com>
	<20251001061028.412258-1-ptesarik@suse.com>
	<9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Oct 2025 09:00:13 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> On 01.10.2025 08:10, Petr Tesarik wrote:
> > Set __entry->dir to the actual "dir" parameter of all trace events
> > in dma_alloc_class. This struct member was left uninitialized by
> > mistake.
> >
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")  
> 
> Applied to dma-mapping-for-next (for v6.18-rc1) branch. Thanks!

Thank you for maintaining the code!

Petr T

