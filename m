Return-Path: <linux-kernel+bounces-832217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125AB9EAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574184C8076
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901742EB86D;
	Thu, 25 Sep 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsiyItoE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510B86359
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796290; cv=none; b=bg7sHVdpwbTXa9gCAUOQRZOKC4L7wKnflLxjx+sVUsWyZE+Ne85NtGErdPipjSBiIITqxHvat942fk25zFkmv4zSMEZiOT0JqEjfqMvT6g0d4TxC8aGP0jUYjEq4L80fu/qy/dezQ2SLOY3ef/mV6Ie1Ln/yxVr3LfLHNJdYFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796290; c=relaxed/simple;
	bh=fQAAEa0IEdGGZklTEH1aa3BIFmCLu/CkQamKj+rGm1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSOSlBc+bSZjs9bl+f2pu9bq+l8Bsd5mpMm8CVrH+bLtXVH9qQXcsNKZ67aSCKpL5Wk2uQ5aXluZwNTQylQ2W0z9qQvUdnr5zKCTiqT7NCBkutbXhdYvIsFQ1x8pAETYLSLmRC8Lxe6svXkrPn1rqWKLbZ71mha6VX8enfie5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsiyItoE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQAAEa0IEdGGZklTEH1aa3BIFmCLu/CkQamKj+rGm1g=;
	b=CsiyItoEUbzA/bQtZfvzedZZz1TdD1F4XaLaWIBDUxczPrkhLkRERZpOzvauNCoqlRRa74
	txyiPfKxvUeSPgBedjFvLYcl0gmIFCRazmoFT++X6FGlDys78tz1rvW3x/wr9m1PSfQTbL
	36K95ehm20DN3rb85VpwNrnA10Su9ao=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244--kgTs_loMJmgGO7Ih_S0QQ-1; Thu, 25 Sep 2025 06:31:27 -0400
X-MC-Unique: -kgTs_loMJmgGO7Ih_S0QQ-1
X-Mimecast-MFC-AGG-ID: -kgTs_loMJmgGO7Ih_S0QQ_1758796286
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d91b91b6f8so13286621cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796286; x=1759401086;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQAAEa0IEdGGZklTEH1aa3BIFmCLu/CkQamKj+rGm1g=;
        b=JXph4haTgDPu1JwkurAK81FEYWOSOfKe2o7H4sjgvtWWqILGXWuF9snYJhTs0PFNLI
         rzpzGFMaBr+rGzLBhSNKaqy8IQxPvR1Qw4bHZCmrFaJZIALOfmYikly/ZwU+TIl8ghpZ
         HS8lQx55IMAsO8WULCTNI845uMTOSbDi43TUiodW6nt3lavylPUuO5OdDhOz1Xv1Ia8n
         qfBWw0zC0R19Lz8rPokZhMClVyEDSNl1hHIdqAmJVUiIsmqOKs+XAuZSuuQ1MUg36/RT
         gqKzdRWUtdOMODa5apKECXZf2jBcmAIRh9H32bIDK31nMgm2iEZso1smhMcFoZ4Nmcld
         0bvg==
X-Forwarded-Encrypted: i=1; AJvYcCXVGSZqZh8S1frURbhHwDhynqPpHuxCAskLbGaty3D1Cwow3OeWvHwJfRZ6d8FgBSsUjx5Qu30Tu1ZHMic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJXNMjVdGfsndMtx2REeoYqdALaTRjKHRS64QxQCYp5M21KBD
	1NjCYUCZlA1eZmPW253BRxAfvHmy7inn8KaK72t1S1UuWXUKXbq+GlbOo00WiMP9oxcX7sYk6Y3
	/Pdis+fnmjA6PT86RYsF2n1dQV9Qgw+vyT9q+/asLs7jmWVto7N5jYyuodTW4kHH7vw==
X-Gm-Gg: ASbGncuQtCRgTg4M+fYlxcBKT+DIGyqPw3mfETgoc1mK7klGsXJ9igqSqdOsz0cZ+kw
	tEtvqn/fIRiuZYiWEHMNeH3e5xIrqKe2W2UjQLtIfBT8VBS1AW00Ee7mFd8Yk39h1e/MYWTYm1F
	lwSqzgUtQw9gGfIIHpvEbK9uwhXWg73JQh41JhNNY2F9MsRCmHdh+R9FPnBSznLna/ZGPu3Cw3X
	jA+G7H3rd1s78fWwO2reK7SINjVvJ6snl3IN0teEdseZxSngCpdo/1dNM7CxE/kA8QRZfi+hNst
	RvAk+3nbpF4KHLk1Rm8J7gkAz5Uui0AwlRKskOkYJhkSDp6Gvx9F3VOSJ69cX3pntdjrv6yDwaa
	v/kHauNF5C5W6qMPe2HivSTC38K5FgWE=
X-Received: by 2002:ac8:5987:0:b0:4ce:497b:73c5 with SMTP id d75a77b69052e-4da488a66eamr33623191cf.32.1758796286447;
        Thu, 25 Sep 2025 03:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdd4mLS42QGKg3aD+HeSL+9y036a9Bge78MNLawf+XLw4VnS4GelLpXVjg/ksNKMa8zAcU+w==
X-Received: by 2002:ac8:5987:0:b0:4ce:497b:73c5 with SMTP id d75a77b69052e-4da488a66eamr33622951cf.32.1758796286037;
        Thu, 25 Sep 2025 03:31:26 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c34ac3a81sm86618585a.67.2025.09.25.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:31:25 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:31:23 -0400
From: Brian Masney <bmasney@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
Message-ID: <aNUZ-9wJkhsJXi_n@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Sep 23, 2025 at 10:39:19AM -0400, Brian Masney wrote:
> I marked this as a RFC since Stephen asked me in a video call to not
> add a new member to struct clk_core, however I don't see how to do this
> any other way.

Correction: Stephen asked me to not add a new member to struct clk_ops.

Brian


