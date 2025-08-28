Return-Path: <linux-kernel+bounces-790266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71911B3A3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7DD172117
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5625D1EE;
	Thu, 28 Aug 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7v6t2XX"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483225A331
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394045; cv=none; b=Lczg7tIFq7fw1aOLE/CGkahGHp7J7Adpd8yEAjhpuoz6PdVMwy+sYhJCeqLnQ6dtfVBDk1y3hrWx8RfmAwpGHk5VnJ9R2AziKZwTprLA+kCEcMvJcXS8p9dVgfcG7L6h5UwUgta5ABx15EUC6VAPicyD+5hptOl6OqMjINNA5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394045; c=relaxed/simple;
	bh=++s62hW7OBa0l+4/DpAnC9LOKmBOE+6VWqOSbmKKErg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw6JZQiT4VkeNojiuEChvcUCnRkKAvlwU240D9/Aps65TJ6BbMxGwbsODyM83OlGiU+Rf94bEcmGbCeB0deOvOx3ZsVIKTtTxvfc4qjXndOAd5kZj6DywQWTDacQDvjWbTiHBv8Qp9ipZZhIJRt9X5SLM33nOebN9qOK10c3dsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7v6t2XX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432dc61d8so108151939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756394043; x=1756998843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QjH1nYmKuaK8/vbNAhIt79YgVpoGEuS/iGXFW67apM=;
        b=o7v6t2XXcmsdJ9PvXz6sq1LELwGJIPDcC+OFMrSpvqCSXDJCIcyX0uKC8E93T+2MI/
         paxBzbZpCk3qvwS1cm6ZH/w9o5wvMrIqqs9hBU2NlgnAEWIGlqGbuUxLCKeWD9UZ/jwP
         jjP4IulU691KFB4K10YElE6OmhYhzgYOwK+4fM6hy6n8Noj2Zy08CrHr/OLaywuzaxL/
         EaG4AWMnTPDzz+IIVoM8ecYoSybSn/1BBB3lNzTRZLjx6ST6N+CLdNIgoL8CxPGvFakL
         SQuM4FruKJpvqHJ54ZmHgxXeG7C/pXPBg3bFM5g/Fhk2ZDK+UWCh2ei2po8DgZCM0dFz
         GcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394043; x=1756998843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QjH1nYmKuaK8/vbNAhIt79YgVpoGEuS/iGXFW67apM=;
        b=JJmT4ZSKO5oQJDSkNj2dIJSv35GFYWjxBH5UHjQWMLpBQ8PLFf8r47TRrMquZY27Zd
         /gzVBSMMa5QpriheqaknJJ0gIwo3gJg5cmio4qz15wAuxQ1UIVB+urdsUtA5ANEtcwks
         JQEfYuS5ma/7gEVXDZcxSFJHENYP62Jj64kvVr7lXMgWQiu+ijOXUYbvI8GrkVsGtxP7
         /Se7v4116wSRV5PbK6UMdk/13h8ruEM2ov3OBJMGbAalpPRUTSeg/CEFqT1TJut0EMN0
         dQL00n3WZG0MxUnZSNs/iQhezj9vGEBzau9l8TXabaL3blKVmp5aTHOPkCL0z0grtBnb
         Pc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa168tQQd3NaHkipmmh9jTP0UvxpQP3+xKHpW95SkdNasbDd9/Zd87tnfZXB4y6GsHEvMA3ZCIJaYItBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVT1WooUPnNjIWcJgifhRRXJqRsLocdWO92bPgLyRLQvdFaoM
	M7Kd1eyV4gMVADX9Pw8wvOtdbhlwGSonYsyv8+aWKAD7yx5mIgosqyR1iD402qmwTQ==
X-Gm-Gg: ASbGncsxq10Ddp2CyOlXtGYy0XAfsrN0kqdq6OaHAY7GmJ85iHTtx8vfdNVCmypB6Fn
	MtjoZr4GvtHgXFSvh0Drv7UxAdWXzJMct4X8U2SkUIOseEl/t+T53anJppgh5H/ycZysTme+zTX
	6q30Jegt5D2za95KBKTcwb8rvrxch4lXDJszq9J21hTEzQVo+OAu2Ht8ptv6rTHPNA+wfk3ikeN
	mv7cQoCNW4bW4QD9VK3bNXyAlNZN90huWIIhn1GpZE1ifWqIqedpQ3Re/aebh9u3PAgDPEPxkrU
	8WPh0YNsNNVd4ukkitKQyNA9Qa5r01QJSnRjdxzb5oWh06BghPh1kKWMkagRTHpeAP8XYraNHMr
	qvQoSW99DYbtI36t+0vAfLUrV2hz52H/t/kFuVbObJ4+eJ1LyrgPZScgvpcDsvBMlgHNx7JssW0
	6y
X-Google-Smtp-Source: AGHT+IHIYBXQTGiCww/PFnxj0YWLbLCi2wzmsjMIYDw9X9C2ummK1XtPh0NkG5nHEbdzSuIpZ0lSCA==
X-Received: by 2002:a05:6e02:1b08:b0:3e9:eec4:9b71 with SMTP id e9e14a558f8ab-3e9eec49eedmr327588045ab.28.1756394043133;
        Thu, 28 Aug 2025 08:14:03 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c75cfd7sm108783375ab.22.2025.08.28.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:14:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:13:59 +0000
From: Neill Kapron <nkapron@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selinux: enable per-file labeling for functionfs
Message-ID: <aLByN-OSeVTLdStd@google.com>
References: <20250827222224.1648500-1-nkapron@google.com>
 <CAEjxPJ4QKnzgoSYgfy8+CqjRigEbW7=B5t4fO4djbO5GnLtCOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4QKnzgoSYgfy8+CqjRigEbW7=B5t4fO4djbO5GnLtCOg@mail.gmail.com>

On Thu, Aug 28, 2025 at 09:08:48AM -0400, Stephen Smalley wrote:
 
> This isn't actually a multi-patch series for the kernel, so don't use
> the patch 1/2, patch 2/2 notation since that confuses b4 (it tries to
> pull in the 2nd patch for libsepol and unsurprisingly that won't apply
> to the kernel). Not sure that warrants re-posting (defer to Paul).

Whoops, I will send separate patches as v3.

Thanks,
Neill


