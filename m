Return-Path: <linux-kernel+bounces-873936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8DC151CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A68E1AA4A91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFBF3385A9;
	Tue, 28 Oct 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR6irS/Q"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B4306B0C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660587; cv=none; b=QPYDxqDHRqZhMUlnTG8e94hkA012Pxthc625i9SLfmkJnzPhBb/NKBEEIS7ZM7lk3TtRWVpmWfPhATTBYLqDiJcetyhl6MY4er0F7bZJBCTNyZ6dHwC1k8b2DXUOkpN4KD/ZeUSqKSdBpWgtipLXv8m4iaFrzQvwjxDE+dMCk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660587; c=relaxed/simple;
	bh=unnUb/eSm49TuPeg6eODeqzKIWef+4vsiWvFR1TFhB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amc/U9cfzX320d0bG95De3G1Hp9T1OATT+v0w4Twbbk5AJW/EpDa7yEVHPDYKduigGv9KzhV3WYGbMr2kz9sjjt9fqPtKA0kYywXdVA6oViB6VL5IHg30U+Co+LfU7EDZgPrTFo4vYBO0DGplLb28tPA8Ika+urODVf+nxjpNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR6irS/Q; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78488cdc20aso78352757b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660585; x=1762265385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unnUb/eSm49TuPeg6eODeqzKIWef+4vsiWvFR1TFhB8=;
        b=OR6irS/Q0ZbSBhDil9rrWYCoZesNdU52tfuJEmTvs/FtVsg+8aNrk6WgzyLiigqPqZ
         CbUHBvk2uN+b1ovusH6FY7vAQhypa049pdBSk3qfQ2RWkZzvyrHJi/R04M8ieiSWa9PF
         FnPkp2PlUr0urRSVUN3vjZKmQhsNrjHRHvqQpUZgPkVK9OsU2pmBFH5Ir1DMKkaujKvI
         fnTnFmomEF5jaG+sgRY50NM6MOnLZuE8DjYj5JsmFanNlMGeo/h+NdzjLio/5Z+se7Om
         Sp2Kiy4TxHYa8dVDU6exojH1+xjK5mFcOB79VYVJz4RHhXv4715WHc0zzKCueoZsU8eF
         QhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660585; x=1762265385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unnUb/eSm49TuPeg6eODeqzKIWef+4vsiWvFR1TFhB8=;
        b=mUP8R0pwV8X5pOJ8fA6V9DEPtxBqjadJYjDbEi1S3tgr1Cg2bdiPZLCnSJ8NxWU2Ue
         AP1nVXg/heIcAsEhluDPtIxrzl0keYvdoYCiWETrjHv11SZxoOcLAj9gNuD1o6AQzNXu
         ioyaQU+jGE2eDB5GDwkCxKhK79T+CMgG1LDcKHlPcOK2W7i/wok7b7f1E2U3mTRkOeCx
         s7sHfsI5ACb9in4/cFynsCBNPbmMDnAo01dGyKvdl8swipyPHPpqSusMbXoDDS5yp73Q
         QBITjmKEPgCt/zLXa9clPuFdebHMgn99eIhpH+0xtX2ildJ3iyaO0D6WZ7oLdyur6pSL
         I7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCViI5Zp+1u0N2CA33YyD3HmRv0QnpDYWEwg26m+2ojrcY5xHiZQX2BMRkoqO6t3sfeDIgtTumbeNbLczNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWGoz7gVfByIR1klbiBUq8jtApe9WjYHp1E8ybMufkCl6zddY
	8OCxDOSZaCtnEe1OScXtDr4O4KMY9xUHbBVdmsKKd/eY1fD9FeZUyM8g
X-Gm-Gg: ASbGncsm8g+JZFQEYBGADIldKf0BdCLA/0wWATieFIJAqQ/XWXWFOHdW/f8/zipiit8
	vXlV8E6XvR3V9PMiSh18JmDZux6BzSMEWR/zWxw2ZtWpelEQk1q8A2Ffl19HbqzgnMGBbYjzYE5
	KwOCWBUV3CZ+MDZRrK0ai68qF+zwhBX3/myPi1VOqFR94i8+btji+WNyFNLCjHKVyhUNajMd9q6
	Ptozhow/bVhuYLjCJbjM4HcHngTKsSD2LsduoQXJGHS6QknuxOEnh5mmrTJZtEj7D0aLKrz+28r
	ZCXNL1qVc96fjHQSL8vjGGA5p2HUa2wCNOnnh+zsKPUdxrEaxnyavb0JQqaRlCaPv9FxfX4FnED
	r6EDjE/l19A4z/z9nLKT5+4NbRWrogxRsDgkGXS7VWVziJTanzj9BZlxraqvcpwGW9gTH8Q65xJ
	axYsh8I16A61fNn8sf56U=
X-Google-Smtp-Source: AGHT+IEvxs7ohiYNwW7xTxAotIV30qgCydIQJhW/9TRA9i6dkFEwWmMisgvTyOn0Z2/Nz9kzUXhyZA==
X-Received: by 2002:a05:690c:13:b0:782:f343:62af with SMTP id 00721157ae682-786183cada5mr36711427b3.61.1761660585069;
        Tue, 28 Oct 2025 07:09:45 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed17dbd8sm28029987b3.15.2025.10.28.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:09:44 -0700 (PDT)
Date: Tue, 28 Oct 2025 07:09:41 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
Message-ID: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
References: <20251028095143.396385-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028095143.396385-1-junjie.cao@intel.com>

On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> Syzbot reports a NULL function pointer call on arm64 when
> ptp_clock_gettime() falls back to ->gettime64() and the driver provides
> neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
> posix clock gettime path.

Drivers must provide a gettime method.

If they do not, then that is a bug in the driver.

Thanks,
Richard

