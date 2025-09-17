Return-Path: <linux-kernel+bounces-820705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2390B7E657
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825473B57A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAE30C63E;
	Wed, 17 Sep 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TdAzRgxe"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E247308F18
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113142; cv=none; b=nDvv7VEWWfj1yYsgIP0thnRscuzqiLa224bO6O6fU5DZ58/LaLvMnkvsrGccsiCLUyf7G9qMIb17vGMiSwIuhudDv9AnJRB+T7xSs5KrM3/TgKbJJTEBF+EooJIitL7do/SXXnsvVzF5RQlGvPI3syeJ5i7sfNIc23+qYHX0Wsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113142; c=relaxed/simple;
	bh=YxDmg1jKrqps1XCrWcHf6Nph6TAAphbfQ3igJXNklEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+hXCvwDMu2sHXFwyBTpFjOwL8B47jm9YrIBkJkgX/QSTSJLo6tWXDKJcqtpG2Y/nW3hAKkLLQrwi4eEncDb0TB9HABxfSw1TdgygyvYKJFFsn6nFYY9li0if/9Tug7WSXOBK42goLUNjmjtBPfxKuZG5D2mEUfmriLJckX9HJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TdAzRgxe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-82a334e379eso221055985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758113139; x=1758717939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wH+ceGKGyNuHnW4Mzcl7LqGu5C+vYLka2lZQEuLsAE=;
        b=TdAzRgxeMZ+ueBN1lxaQyBZ5bSMDpj8X0AzUsCt/5WDBgP7eNMS3B6ZlEWjZCG+fUE
         u0PRpc77pH+zaLLYeuAE6/8PII91Zu9RWdPcx2WmLwXnF0Qpg+Ge+yGv9phq9moRF7k/
         rFalhkAC8bU/E8ukzo0KQ7ecCQ0jXgiHm4TYq50DCQ5DBQCxVZOeH9EdQy1RpWG4rA9O
         39GACPDDEyqXVFTU3GhHAkUXlMIQOeTDVuOmtQUz4RKuYwWYTlJyC/GvKJuI/4W+CJ4T
         X3F6vEoK391T1T6Gfi966J2Nl9R4romnVDwwsFmiSCkAXlBzaj2nh78CFlhzIiMvlbJD
         8GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113139; x=1758717939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wH+ceGKGyNuHnW4Mzcl7LqGu5C+vYLka2lZQEuLsAE=;
        b=ND+ojhsGpNKWi+PgnCC/R+d6CDjfbdxYG+FSChWbvuh1TtwjT061hiHiFMLnbx5Nh8
         2O/1JsyaUroKoLoEMysbMJ0dLKURH/xjGqrQfw1ZS73JuyQpLx/I+UTZcHg3qOKQAvd1
         x3xcwOixd7UUrXhUGrZP5S/kB5LzcjSyMLDGkxKFb2noj8oBDt/MI8VPHU7KLhv4UVnw
         W+hh1FzRFaZVQpEruHsjmdwA4oEzXOG/W1ObafSwq3uMsnAD7kCJ29JzL6JcX9GZ1mqq
         9uX0VAbVrVWbcvsuFKcVr6qClAo/ZYUFr4Ui2xLEeYyNuJeLm2vrTQhsQGmAnjDiMkPQ
         J5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlDcQYqtFLytcyRErN8zoz4+uQpEkUKbSvn02SQJbb4Ekq7EC1D/z7DlifHWD8OUXxhjOJe04kUmBbcJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/49Cbc9V17QY6xKLwWoiLNzP2mYpkhqAJZ3L7alN88mNkL43Z
	3wA5JWtNVgrxBBBMxFf7f+YF5mvYyAVcvX+u5uTGRQsLUBiAp22zxERxMnBozZ4Icak=
X-Gm-Gg: ASbGnctT2s6xZcJEgEGSNKW/+eteTAOLT7HY05L9BwHkYW0ICMwldLCnXbj9Koa0eeU
	4uM/pMW47v4iTfW0AxH5g19LKB3Df/VSDzDIKEdeF5qEOIIg4IVoQmWVdA8b7PdUYYG+3QxXlXJ
	7hFrFG3MD7zw6/CgMHdoS8drriGn4DTd1E1JX+qAqybM7P5ggq1P5YbCodM2R8xVFFLD/+gTVMZ
	qADflsNadDj74W9ZTgqVT6c29QoEF5ocN85DZ/fwHyiDFEovqOHFF8LPnlN5Vnoc7AUJ6TVrmuF
	94jKGMZh0spfx2FI8wAuwSepM0chptMLo2//5UpA2jbcnWqATtFaFDGQ8R+wZat6npWfG1IA9kg
	NqCZe1XM=
X-Google-Smtp-Source: AGHT+IEZFd6Ciye9ajHh39C9NxMT19QjB09+jHNmDMrNjKMQ1BbOHVaOyXCny3oyij+bcEfEw4hy4g==
X-Received: by 2002:a05:620a:2683:b0:827:d83e:a64d with SMTP id af79cd13be357-8310912bd9cmr227559185a.27.1758113138910;
        Wed, 17 Sep 2025 05:45:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c8bb8f46sm1107416185a.10.2025.09.17.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:45:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyrXV-00000005jyn-30nQ;
	Wed, 17 Sep 2025 09:45:37 -0300
Date: Wed, 17 Sep 2025 09:45:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Message-ID: <20250917124537.GB1326709@ziepe.ca>
References: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
 <20250514085421.GO22843@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514085421.GO22843@unreal>

On Wed, May 14, 2025 at 11:54:21AM +0300, Leon Romanovsky wrote:

> According to repro https://syzkaller.appspot.com/x/repro.syz?x=15a08cf4580000, we joined multicast group,
> but never left it. This is how we can get "ref=573".
> 
> write$RDMA_USER_CM_CMD_CREATE_ID(r1, &(0x7f00000001c0)={0x0, 0x18, 0xfa00, {0x3, &(0x7f0000000100)={<r2=>0xffffffffffffffff}, 0x13f, 0x4}}, 0x20)
> write$RDMA_USER_CM_CMD_BIND_IP(r1, &(0x7f0000000180)={0x2, 0x28, 0xfa00, {0x0, {0xa, 0x4e25, 0x10001, @local, 0xb}, r2}}, 0x30)
> write$RDMA_USER_CM_CMD_JOIN_MCAST(r1, &(0x7f0000000900)={0x16, 0x98, 0xfa00, {0x0, 0x5, r2, 0x10, 0x1, @in={0x2, 0x4e23, @loopback}}}, 0xa0)

This should be fine, it is supposed to get cleaned up.

I think it is more likely there is a refcount leak on an error path..

Jason

