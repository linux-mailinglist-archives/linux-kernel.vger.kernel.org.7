Return-Path: <linux-kernel+bounces-803022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD6B4598A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CF17C48A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1358F35CEA0;
	Fri,  5 Sep 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IiKEwvhX"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714235CEB2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080142; cv=none; b=mlM6sgCXaSRNjUvspL7bBlW/eeaD+xDw2PLe1xNqM+1wfBPu+2R9rR6C/Z0lTXPd/MoefU4eF8hccZQvHBzRJSknk4+DuKCGiSaru/Z6CJSY54+eZ2N0vxiMs/hE+aYNpmWzLVVSIhv0ekO/WiW0yeT7iCrb6kTXhGX9CWbTARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080142; c=relaxed/simple;
	bh=JgssgQ44iAWEZiQncHgrZHAyaiEfCUhGCy1oI3X6Rt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaWGKh9+PgQDFV/VdTpXr+fKsoppxKhof5gmn1OVuHn7b+cNGJbNdl0iV65kDYDUm6oeyplg4+db/aRELvHGgSlWuTYWsBfCCZz77hgPKICEVMROb+LmJsMBihgFdyuEf8Uo2Xisb9eE6tOri7dxCRs0ry00p1CY5wspaUV7ylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IiKEwvhX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0418f6fc27so341655666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757080138; x=1757684938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohGQSMKwVj1UObMGtjXFeVfLrCd5JxxmvFAFzhxErEY=;
        b=IiKEwvhXvx2czSAzQlt5aJ3gC4oo2gRlu7JUGS6xvj3VuWDlOtDfXAKE4cGhrxHZyI
         JP7WBJf6i8utZpmAtZYc9A2g18rD3wLIyw5k9FcHCvdLYbRzQsAbYwAXNdZ97Yx8EPVP
         E9dfuIfN3cxxhjivfPCT2CH5rjGwEgIa4FZgm2rk0f4xvBzXuWOwfudRH3fPjxcUcyEO
         XrVbU05cmlEt1bczBfBCvM4GMfmcFXNyYkv7KfdGHPBZhEBmyw0JlBSHc4BsiHxczNJr
         GbvTtkqlmiMgydcO3ERNvq2mtMNkbDNmFL8HJdmfsl2ZtzysnZqegg28Ri5WC/8moFtV
         8xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080138; x=1757684938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohGQSMKwVj1UObMGtjXFeVfLrCd5JxxmvFAFzhxErEY=;
        b=DP0klYChERc3bcv8qvEWA8fcqcXsI+lWJJU73TwFj09uqeQ3qgW9WsBMWF1jPLEpuN
         B9PnBnrr9G6Xh0EiKAu4Zq+NqqycTlxs4akyXq46E3SGWsgDrJgPgkkWb5ArCT7LQguU
         eW0H/bvOT1m6fK8v8t/AOZvNEF6Vk99XYYjaSFpr2rrgSYUVq4YQY/Z1jS2gpmrG0dgE
         Vq+wVyB/+tqo96drkXuoarLyYlGA6RUYRJTWyBfAuh3fVOdEG6l+8x9f4pqSVmgCZ4L6
         rxJvp40qNJzuwa5lfAAestH7w9AKSxOdJC83PIeENqQ04k7n78P3LR8yJiPpJm2PYQCS
         MlWw==
X-Forwarded-Encrypted: i=1; AJvYcCXljARzDO1ufew97Y3YMk3oz1reLu4yxYlVRzfz3DyeollN09Je/W0GXiRYqQ1kJulOlaBGx5c8cVa3OZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvn6bUhVT0z8q+01wb1wlT2FkvfQWrEnX3ATecx/o0pkL7uOTd
	V7TxDbBw2dZpXVI9iL6wGqiu87zCAt0UfTdXf0NGv8duWTWQIw+0D6V7waMdPhDYmd0=
X-Gm-Gg: ASbGncuP5PE0rh5LcChHJdrr3CK8qyoMGWH7qKdxlM2UUXb1qqat/u8+e9XBXFX78mM
	Ep9wBrWbSnrdlfYKHD4u0LH0vZTNWy7JgoDYgFGer/BMD7kkX8qoYtuPXtFSH2LiWmcnbRjrtHt
	s21SrbKL3VNQuQPwoWJCZaaRmJAyjrhdPovRog77dxVJfDyw3eViXKMtDu5icgXY1o/AzEwspsC
	oZUTxwnEJLa+G2FwXDHVos/xMSbLsi/28ul2V48xVPYJP7GTAmwxgQeOBM0Bs8iauYP/pWPowkl
	U6Q1q97L2eAkqIeOfLwFQimGlgiZkLxLIYAnmwHr+A9dsaYUpHVm7sft1XSHkNaCHRG/vEBhlH/
	yPDw9ijzKh0fDov3kneFf0uLSe8RdG70uLaL4
X-Google-Smtp-Source: AGHT+IG8kzDpVkryXwsWX0ypMJH1Q/GoqYF6znezUko5xKILYPDfjCeWqnLDJjEeRbeInNjICaV63A==
X-Received: by 2002:a17:907:86a4:b0:b04:4d7a:84f6 with SMTP id a640c23a62f3a-b044d7a8b80mr1329355866b.2.1757080138297;
        Fri, 05 Sep 2025 06:48:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0476e0d61esm496789166b.53.2025.09.05.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:48:57 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:48:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 1/4] printk: nbcon: Export console_is_usable
Message-ID: <aLrqR2l1A11lH_kV@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-1-cd30a8106f1c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-nbcon-kgdboc-v3-1-cd30a8106f1c@suse.com>

On Tue 2025-09-02 15:33:52, Marcos Paulo de Souza wrote:
> The helper will be used on KDB code in the next commits.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

