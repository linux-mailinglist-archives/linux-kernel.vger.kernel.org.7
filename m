Return-Path: <linux-kernel+bounces-803156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F576B45B61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CFFA66AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20C2F7AC5;
	Fri,  5 Sep 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNy9tD/9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CD72633
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084307; cv=none; b=s0E7dC9dRQ980+//wi3m6cyemb/5mDb+j+y/Mync8NdtSthwM+pQgxU4MwGiP9trk384WZCWa0Fqf2ZG8agtCDPKZbMjlvYRIx1M6K9xtRtbed8592hBB31b7SWHQngDyAMK6Z8C7CpL8gtjCftzfQiQ2oS9uLlXKgNimVKeEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084307; c=relaxed/simple;
	bh=G56oMzOjsYVrjlf9HgLRUbAv1aA5ITWzZQDv2p0HDok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neM5MRB5NONQGtAB2pyOSNwyJfQSWHT02PU+04VBIZNcS4pJscRW9CqdppCxNOs76mb+n+LwuG3uAPxd5oNUhkhBs93sKOqg5SlP/Otr95k6/CEQ+DWGCyCVHFAa4BH7p0EAuPNtLQf2Nop2pDZ68FvTjXYJ2qbgaVZecMLR5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNy9tD/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757084304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8sWmtjiwnBLMCNvHDa+POELZazfSy48Vst2ZjiMCgD8=;
	b=gNy9tD/9qoZn5TGsep5PLHjr6Uo99AJZypF4HbLE3cve3rM+7RX0iLHeJsEULg4oowCHqv
	vhY/z59Whka20eNbp8U5FmXyEzubNvL7fn0xEzluN0YAd1gVJGup/cyGjl1DAzh9R3hnW0
	EbPNPMYIWm11n44hFNVXyLuX35v9fu0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-BYCzL1sXP-y0G1IRB9swtA-1; Fri, 05 Sep 2025 10:58:23 -0400
X-MC-Unique: BYCzL1sXP-y0G1IRB9swtA-1
X-Mimecast-MFC-AGG-ID: BYCzL1sXP-y0G1IRB9swtA_1757084302
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8064b9dd37eso405459785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084302; x=1757689102;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sWmtjiwnBLMCNvHDa+POELZazfSy48Vst2ZjiMCgD8=;
        b=FLnjUQDPbTiD9LOWTTq0OjhT9zu+7L9Ye34agIdHo3Ny1TTP45CCg2O/O3FImdxyq9
         MzkgN7fQK76TRP3rJjvzwTNVZEBthKmuu8lflOEvJ1fmef57ZJRCUakMO94Ph9B2N6Rm
         JfNenVOl9FEPscjCkz6KKZ8trMre6sXYPLmqZl1VHzQROlMT1yX4yOQjRjh5m/x5wVDO
         AZfWlVxhiVZU1UcrtCo1vT9Q68yIGByhQ5NHLJBl+KFx0lb+GlOlh9HvxZsJugW+DzqG
         dNgy690X9szoDIbjdnz2Jnd7gGRWo2x9+JdLuWQd5OnaQLqDk0fKvmD9ecf85NBtFTvM
         wKGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0IVyFCNWMkm5B65o8DYVc2KOHHdggSWUHu+/Kx+q/pIhdalcx4AX/Bfdo98besIMME81R8QSkP89ZFAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVqiuq1frjgdAS4vaihQxdn9hVYSXb3NZIkb1sd6Eq9KzNfXQ
	C3ANH88HfeIGRtJ2JBbG4HfzEHSD5y9LJ12gS+Dn+wI4wvk1WwSkYWJV2dkM9MMZp6Nm9c+bEfM
	64Hz2wt2JT7eX4DSxoKOm5MQlJnMPMbDo9v/xz/lOM/HC+GTmutCcMxTJ2UsOptA/uw==
X-Gm-Gg: ASbGncsf5GNqmSCC4ybziyl0378g+BEQHm2PlLpni0jVZvBiG4mzyodJqz8ICT+biR7
	vWHilbAc2+Ub8auvBoiDCvUKzwrlpEF3765j4FyZiqybLBZCuQY1Z6fMLWfvuEESgsteLkjEHVq
	GhaoVjrO7BNMjG8hRgHyxDHS+i+a8mxorRnbMZPJkHIyxfGE8H/hITdvaPi4NbQFXlIIpmBi28k
	sXSX04kiQgOU6wA+x5jMF3u75bmMQ89Or7Q5vdoU1F+ODNqWE4syQwfdHS9PEQzVJA6L3HJcjgu
	ofdDG65VAFtJNrP05dk0opEFPavC+62PDrggbBoZ7VHJxat3qfOVFC7o1Qup5bc34N9KDoPoM+U
	HrxifDvRZyXM5YbIFdJk=
X-Received: by 2002:a05:620a:2585:b0:7f2:d9d3:f5da with SMTP id af79cd13be357-7ff284b1c36mr2949666585a.33.1757084302592;
        Fri, 05 Sep 2025 07:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRAz5VwtsVUROYHU2rQWET40PGS5RQKqxfBOTI59DzOUvzzQv/XtrECGGTQvfuYUXLNygGQQ==
X-Received: by 2002:a05:620a:2585:b0:7f2:d9d3:f5da with SMTP id af79cd13be357-7ff284b1c36mr2949663185a.33.1757084302145;
        Fri, 05 Sep 2025 07:58:22 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80b65dea673sm436066085a.71.2025.09.05.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:58:21 -0700 (PDT)
Date: Fri, 5 Sep 2025 10:58:19 -0400
From: Brian Masney <bmasney@redhat.com>
To: Biju <biju.das.au@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for Renesas Versaclock {3,7}
 clock drivers
Message-ID: <aLr6ixZr4Lek5p9X@x1>
References: <20250905143441.7082-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905143441.7082-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 05, 2025 at 03:34:38PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add entries for Renesas versaclock 3 clock driver. While at it
> add myself as maintainer for versaclock 7 clock driver as Alex's
> email address bounces.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


