Return-Path: <linux-kernel+bounces-844273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B343DBC16E2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C893B43C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742032DF157;
	Tue,  7 Oct 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm4MMU3g"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB892D94B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842360; cv=none; b=t9r1avby0u4dzcd1pGIfGo/BWU2i0syS0tK1DKfdZYCwa6Dp3o28myqStryhaVpgWs9aH9Bnoiv+2ViC+Fi5WgMtVguK77m7pT3gYw9+9o9+akCuFwsiNa3jaqtFwzWT8NXEiqfIq/98jOP8RJz9lHAM1QXfba0AQ6OM1j+Q3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842360; c=relaxed/simple;
	bh=hLbvYiGrn95hNdclry4paH2tViQndDMSYDGnCLxfDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D41/XdlZ6Kwn6R3tf6JJhbWrGoDxOl2prRw9bGa4NurikrlBoK93KVL4MaNz6WbaVjCMUyV7yyNNypvl7FFyDs0ZcphTRfpPoofbb3MTOw+NMIAqKOg3wPOUbZqf36oZWZbKWN/GmlAEnzR/GYQZvt80oEXMB85PD6zHMQmX8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cm4MMU3g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e29d65728so35329295e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759842357; x=1760447157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZoEfMjGCa0h/Uane5YdUsRF/AtaM6l7u/C9eK3tKi0=;
        b=cm4MMU3gGh35mjvrhaBoueZgeITHTc1hFr9Xhug2YxMwYlgPas+1tUeFfqb9ZvzO1J
         NgSoR2xdUbcSHZP+y5bqK7+g2LNQC+yAN6D1ktVFR/R/5O5hJLXM2p9bDwiBAaoN894L
         LCCydYg/QepC0Vb4MgWvwHmPGL4oZVtoz7ZMZ7eqkPg+MXMvxwUXXxOUtJ4wMFbMDHAl
         LmDb1lq+xIyLSlJO+H3CMR8g47Di2EBep2dfv/k8ixjPZYbxG0kcO9U+cUdEygpMRSBS
         +ww35MkMLfvwCtTfdAMmDpX5WFtQecKHO2rJgyQ3nXW+gg64TByi8GcerLzAi9+Ccsts
         TNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842357; x=1760447157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZoEfMjGCa0h/Uane5YdUsRF/AtaM6l7u/C9eK3tKi0=;
        b=mygZJh+CvuBnNa3CR/BkDiGt/spHr6RvmkC+QN1toaihWXTIVNZIPrjyGlMQSQH0iE
         ctP+p41aUVXOAx+AmaCNDf2IT7wcGxXI3D+KpdPbmBTY/lhDf4uYa/gtQH+WasFPDc5f
         UnUvSY4BqgYvc/KxTsIhw34eERii0x8EhGQpG162TjXAsBBs0xc0tzpTRCiKPXjUKhrP
         2GUUmB+hDjpysGqKuD/i3kf7PziAwrCpAi3nYeucA+4Uu7CqJ7WOTdCleuwkpLybRAIC
         kkrHNWMUwp1tCpwsfno4rnk1bCmYwNnWX1O/wxiv9xgWHExU6eQsR1UTu9EsDM6LWi8c
         k5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWz3OWfyw/dyIkUfJIYH1nIxBgHS4FhHQEnwRZ9bCsOix1mLJ7YC8LKooOfGmTpSk/YQyuEC3+hPL4n/Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7huYYNAqo1rNmZG1PXsT0wZpVGA3mJXW2O5ztKNCbZoP5bdfY
	tV7BgUxCWN765CmFX8mkOgvWszkw8k9RUxyFP5+YA3o57WNVjdwZ1POIKJUAH51Sfi4=
X-Gm-Gg: ASbGncv33uEIIwKVlX4DaK0q22T1DrerWM0BZ+Zlvxk6i8fZirL+uRATy44Q5UC+9Fh
	UwgXNy4IjjAqrv8pmH+NNy6Ods1SPtCPAt5vz05bjB6t8a68JFVUHqBjIGEUrRQQpiAb7WpP+Lk
	UmKOGNEZPXZQO9HgkurXouxH0vQxB9GIvwfWeonqbn7eGV6F46pf97+hUT6V4zr4Fu9zDr0wQOo
	CySQVp5C8Zu4tjgVp0JWqfv2Jr3w15rRFbYkJCSzAJB9UVKQnCNAJxBz5/N0626anChA5f+7OSB
	RV71/Qf9oF64daptsrGHfqadjogxg3zjJP2hi3/yE9i2yMtTzMh6q24c2SZQXA1w0t9A7rqcR17
	xKh18LQoevDer38h3fJR4dDTuyzbXRz3C8uAPuXd0bgaeK+52gXHnawIE
X-Google-Smtp-Source: AGHT+IFRlbAen4/r+XsyINyk3KQxN0S++HomOpc//Y3MDi1jdyUcyo8Q/HfG/nXi94cmHvaMwK+0AA==
X-Received: by 2002:a05:600c:8b45:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46e71168aa1mr111024305e9.27.1759842357150;
        Tue, 07 Oct 2025 06:05:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fa57d8f9bsm12241975e9.1.2025.10.07.06.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:05:56 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:05:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Murad Sadigov <sdgvmrd@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix integer overflow in write()
Message-ID: <aOUQMZQr3JwNTUYX@stanley.mountain>
References: <CAEuvNs2b-_Q=dazKjhUwJoZ5XUpjRsf-FrCOTR_j24T+EG-f=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEuvNs2b-_Q=dazKjhUwJoZ5XUpjRsf-FrCOTR_j24T+EG-f=g@mail.gmail.com>

Hi Murad,

This can't happen because vfs_write() caps len at <= MAX_RW_COUNT.

Presumably this is your Linkedin page?
https://www.linkedin.com/in/mrdsdgv/?originalSubdomain=az

When you're doing the analysis on this sort of thing, it's nice to
have the Smatch cross function db built.  I hacked up the vfs_write()
information a bit so it says that len can't be more than 1G when
actually it's capped at 2G.  I did that so that count + len wouldn't
trigger an integer overflow warning.  Those are prevented in
rw_verify_area().

$ smdb axis_fifo_write
file | caller | function | type | parameter | key | value |
     fs/read_write.c |            vfs_write | (struct file_operations)->write |           INTERNAL | -1 |                 | long(*)(struct file*, char*, ulong, llong*)
     fs/read_write.c |            vfs_write | (struct file_operations)->write |           BIT_INFO |  0 |       f->f_mode | 0x40002,0xffffffff
     fs/read_write.c |            vfs_write | (struct file_operations)->write |          USER_DATA |  1 |             buf | 0-u64max[c]
     fs/read_write.c |            vfs_write | (struct file_operations)->write |          USER_DATA |  2 |             len | 0-1000000000
     fs/read_write.c |            vfs_write | (struct file_operations)->write |          USER_DATA |  3 |            *off | 0-1000000000
     fs/read_write.c |            vfs_write | (struct file_operations)->write |           USER_PTR |  3 |             off | 
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        PARAM_VALUE |  0 |               f | 4096-9223372036854775807
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        PARAM_VALUE |  0 |         f->f_op | 4096-ptr_max
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        PARAM_VALUE |  0 |  f->f_op->write | 1-u64max
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        PARAM_VALUE |  2 |             len | 0-1000000000,2147479552
     fs/read_write.c |            vfs_write | (struct file_operations)->write |          FUZZY_MAX |  2 |             len | 2147479552
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        PARAM_VALUE |  3 |            *off | 0-1000000000
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        PARAM_VALUE |  3 |             off | 0,4096-ptr_max
     fs/read_write.c |            vfs_write | (struct file_operations)->write |          CONTAINER |  0 |        -32-80+0 | $(-1)
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        DATA_SOURCE |  0 |               f | $0
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        DATA_SOURCE |  1 |             buf | $1
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        DATA_SOURCE |  2 |             len | $2 [m]
     fs/read_write.c |            vfs_write | (struct file_operations)->write |        DATA_SOURCE |  3 |             off | $3
     fs/read_write.c |            vfs_write | (struct file_operations)->write |               2059 | -1 |                 | y
     fs/read_write.c |            vfs_write | (struct file_operations)->write |               2059 | -1 |                 | y
     fs/read_write.c |            vfs_write | (struct file_operations)->write |           BUF_SIZE |  3 |             off | (-1),8
$

regards,
dan carpenter


