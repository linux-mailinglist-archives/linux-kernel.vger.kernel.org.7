Return-Path: <linux-kernel+bounces-869023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED778C06BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0245350915D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B867C3218CF;
	Fri, 24 Oct 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="fPrDeCGZ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224D2264D6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316621; cv=none; b=qr3VBfNhx99laQA6jnP8r1rB+xq69DHVjIVUdc8TyUZHvcmtw7BTGFXpZfsSa6yuAVuvOTEnVHSJWv+LudUL0k4378B1QzIrC7ylX1H3Y0+HPbhWPeabV4V2q/7j+JLD/ZaJJ7EEbR5DZQYivdgiCelK+NW5CmckYwX22pgQrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316621; c=relaxed/simple;
	bh=RJMT9+QIVXzKtRN9e2d9T8AJ35/3vMI26s9TCdhfyCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYbOJ3wF+7la5jvaZOOcxzW5A1HQLeHOnPBkwh/lo1xsjc8x+8FZFEjUeiOkZF+DSNPl13LabPdcAFbyvP3q/CTAjWOeNH2JcPVnObIvdKomlMu1DpOIpavi4EdOyQpiA9SljFTDfmB+8FD0xZtFp3LdbxVF/BtqbTfNGVtLYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=fPrDeCGZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso1587675a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761316618; x=1761921418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ksaN6GRnCMdji8lVdkLauIuUldwGEfwf0FIgoCelrk=;
        b=fPrDeCGZHPRvWNu71H4W90A3/reurX2h1wo82au5hvE9EUp6UmUn4N1QKH5x4Bsx/r
         E3Y2XBCzuVUZ/lSns6bML1r5asAjAAzRWDMDi9vx/auxgqLe4NT/aSmkaXB2LYIZptN8
         2EcyPsqrT/WDw7RkrcuLfPHXle/HEG8Du//Pjxe3C4Hbu2i4i9TaQ3XMpLVSgbsvBj66
         uqnYLDv0Se22APw/zIilJBMZsRocaUXhxb7/VqqMtlqNHrxhWpuFvWTXBWyLrtB1O62F
         2hQHonWU7SIqPLLRPYQDvjNFydqW7jB9i6ogTVvHEhZkjLx6XjZO4u1jycs27ORfd93s
         of6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316618; x=1761921418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ksaN6GRnCMdji8lVdkLauIuUldwGEfwf0FIgoCelrk=;
        b=KUM99y3JtaGsV6+T3qEEaKy88pSYFsBAVkvPY8mp5an7GMhefNJuSbfsuOhHnFcpSS
         L4DhttymjmCFsDobRjyJmqn2xcRClfCIYUDsBj83kk7UcLZZTpmtPYdi+9PJOt1bC+P8
         qdHMICtsHZD1s4862P6mVUzEJWRpyp2/BZoBtfOuPw2Yp+Rq90hHFYBlzi0kNtV5lqxE
         oaCyLW2VH4qj3Rf4lCOLH6qALxaflHKOqUVAtkhGzWoyZCkeOC0Z8O6XClKllbMN153g
         6ZT7daD4uPFPtjMDvzXLjde2FZDvtshAjgNqrD0kgxL+0sk0U4bXlW/joPd5sXG6sTA9
         7Abg==
X-Forwarded-Encrypted: i=1; AJvYcCWFqaiitOKV1kRpzs7cWCYwM5x22NAvoiNMsTyZ4ZHQGcnxpCKQWrcVQNNNAnBJ6/fI2QWMe24PW84hNVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgaUgc3nOx9j8n1OhcxJOsc/Ymm0BdMGgZ83WNvYm1/PcmPJJ
	9BRtr2JUMYFJH2ZnW9IAInusFDBqHY5+UGqD3vPGzb9SFCi+Haht/GbF+NPNub01EV4=
X-Gm-Gg: ASbGncshkK3PxOAc4lBTc7f2XHCNealTjgxqssjQ0i2fvdrHAbN7qzHvHpZ7iX+ttZZ
	bZYiKviY/W2plM8eCElkrbbqsl4s9+wY6yRVnWS9wBaBYJtPlBnoHPipJz0VFcSdDtgvyjhqUzi
	QT2A2gOQGTB189O8yr/hry4VEnRMp5W1wzIW+bbfWfqsxYNLGoQZKnrNQnI2gCatgrhI6Bck04M
	4E4jgqwfWScnVuIbqzTsuRljcN6JGOGU26VB6WHRKd5S2KnRZ9qsGyDZTZnDqBAlzUmbXj4GpAw
	CEzaLGUwIpU5UERviRr0iwjFsyk5iBKAepUFujHeacX+RygSDdgLvxVLXFOgxv+urNxyz92eb55
	q/pShm4ooWNF3HSSpWu06zVjNTm4joVp1ZHe9BYunrzes08hfC1VbKN3G6ST2EqsY
X-Google-Smtp-Source: AGHT+IFOwTRsMQ4NitjmYobeaQ0tnB6ugqodGJAvpVc13mnPb3+P5gtIL+SJCl9IRfh/Zr78Y+cxPA==
X-Received: by 2002:a17:903:3bce:b0:262:661d:eb1d with SMTP id d9443c01a7336-290c9c89f9bmr369303295ad.1.1761316617557;
        Fri, 24 Oct 2025 07:36:57 -0700 (PDT)
Received: from essd ([49.37.223.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f4283sm59076805ad.85.2025.10.24.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:36:57 -0700 (PDT)
Date: Fri, 24 Oct 2025 20:06:48 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, habetsm.xilinx@gmail.com, 
	alejandro.lucero-palau@amd.com, netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
Message-ID: <jz5q3cbingdq5tn4ahved5pxcez5joeu7bcq6lso5qhc33zxsw@jkrijw6chblw>
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
 <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>

On Thu, Oct 23, 2025 at 05:48:12PM -0700, Jacob Keller wrote:
> Why not make the caller responsible for freeing desc on failure?

I put the free inside because another function efx_mae_add_mport 
called by efx_mae_process_mport was freeing desc on failure, so I
followed the same style of code, but yes making the caller responsible
would be more cleaner. I'll send a revised patch.

