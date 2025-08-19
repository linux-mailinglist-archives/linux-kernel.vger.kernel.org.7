Return-Path: <linux-kernel+bounces-775532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F421B2C02B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2043D1888FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8F322C92;
	Tue, 19 Aug 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzxCTjE5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244B284887
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602638; cv=none; b=WAJGflBa5CDXqCf2d5TuTZ5ugOL13R5FmupROSj0XiCBEBoXTNBFVLiW9JmEgeGAmyXuLIdm0LjvmbGx/IEx1URHL1OHCqrgTmv3zMz1H0P4LWXD4RxTbeEP3iOHexNIIIY5VU6idD4O1y+bMvf7ybVQqjttCCWoA46Ja7QEQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602638; c=relaxed/simple;
	bh=NyUnyTFEJY+Oq9e4RhM8K21PGZa+v+LrJKbZlwuLf0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F1mxhG5G+H3ilLvEoENsRMjVIbz/289cVj2hwM0/HQT3KXfnmk7m+0AzibPBCg74TAKnlrbKLbSwbbSMvMic6g9uKX9kRiJRqBaj5U00t+UhTmYl7NcCs+g+BsQA3TUO1GHHT3wsftidGGzXoUqhEaZ0g/lDcPzwlPEROWOCG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzxCTjE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755602635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyUnyTFEJY+Oq9e4RhM8K21PGZa+v+LrJKbZlwuLf0E=;
	b=RzxCTjE5yXuPS53iYnxYo6qvsDEhfCL2q9hnx0OM3Ng+GBOPSMKjxDYC0/MgcwJ4cl/pLQ
	SHZI45T7Sp7GW9RfIeQZG+OyBK0tPZureAtTZPz13UbF0tcvFBClxJxaigWZbsNr2UDmGY
	NheGvsibpUjL2bmSLaVoKyI8m8ViKeE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-MXTt38YuN5q_q2KHN_LGBA-1; Tue, 19 Aug 2025 07:23:54 -0400
X-MC-Unique: MXTt38YuN5q_q2KHN_LGBA-1
X-Mimecast-MFC-AGG-ID: MXTt38YuN5q_q2KHN_LGBA_1755602634
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109a92dddso167006511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602634; x=1756207434;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyUnyTFEJY+Oq9e4RhM8K21PGZa+v+LrJKbZlwuLf0E=;
        b=T5RadoFZbyqjqtM02nal3b6FM9f7klOWySr8PJYY38m491eHC7S8yMfY+XoUN8Q/ZZ
         7YpW5iFcw1Y0+ykbLf7ZAU40/1O3PojWvci7+48Ti0qua+otwDIrAhOW/smcd1p7QGjc
         QRmqmV6fS9HJk7yBzNxiPIw8wxT+BS82ZE5N47nVyvvh7qayUPLKvMrKX3nxuv7dMsZW
         Y2YP3mxzBqwZ3q5o1FiUFxzdbsPp8nn+bQNAS0eaJFBQLgxEWctjLAwSt9f5+OkgtIdy
         N19Gu505XBbBZb9HuE4w2UtyJWN7rdaARX6DP6qwZrvdiQhbm7PwIsPFWQx5fLFETAn2
         Bp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdN+1Dexiv8N3aMQ8UVwiW6mhBuRlfp+LcB5ImmY3Ef29IaIMw8svJwxAbUlxuyqFSpXr/jbeNf6zQceg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKJBL2Jk/ecQCAHUe5MJc0CtiQdjlVykHHGmaZ1C+euYS4Ann
	/bGki3c2oAE8p3vuYYAatIH86N72tWZZHmRne6DbKNTKwb/JJXOnjQgKhOKsoJlYZ/FQCihGUzK
	JfRNW224Bv+v3MfrGU9aRHASULTAdh8pSw+Gi9GnVIH5E0l8pIlZGl2++jjg51Tuxbw==
X-Gm-Gg: ASbGncuJBSlhSfdHD+Fm0wjaTW1XzQFrscAb8kTIdEGl2AeMyZ4kpEg36faP+LuCzS2
	sunVcqrytuUDq35ERjF0aGeTdKTbSlSByKj3YcrbHWXBMlv+r44DuqZCeyk+FhaXdKCD9d8yQcm
	uEoksa5pKgTb73r/RSyI05mDBxmpiCl2svyspNYDPxD+ATrBQ1VLmyjw/RgZSvgRqjDFALoQeSm
	jpT1iSDe1t3rn4E6vT0PCxRwTv5qZD36GsNYrPoQhDtfVPFYTvvov8cqkn4OjOF9oVCciKNHMZi
	MAnMS365duwHtz/ntziPR052JBVDf6qZvF/b/NgJvjrdrDyyoUHGW70Ew/oQ411r2fiFd4D7S1t
	S3z6Vzd99wWXvGABSf5xdA2ZF
X-Received: by 2002:a05:622a:8c4:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4b286c46be7mr25562621cf.13.1755602633952;
        Tue, 19 Aug 2025 04:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgbMZLlN93s/uP0HYGcw3ai6bE1Okqhwtg4aEBuh2Oucwnfsprp7rwWEwqhQaxlf1CtmcqaQ==
X-Received: by 2002:a05:622a:8c4:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4b286c46be7mr25562351cf.13.1755602633527;
        Tue, 19 Aug 2025 04:23:53 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1aa56sm67162191cf.7.2025.08.19.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:23:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org
Cc: mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
 dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
 juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com, Fushuai
 Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH] sched: remove unnecessary check in sched_{debug_}start()
In-Reply-To: <20250807034016.43446-1-wangfushuai@baidu.com>
References: <20250807034016.43446-1-wangfushuai@baidu.com>
Date: Tue, 19 Aug 2025 13:23:50 +0200
Message-ID: <xhsmh349nimgp.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/08/25 11:40, Fushuai Wang wrote:
> -1 is a legal argument for cpumask_next(), and cpumask_next(-1, mask) is
> equivalent to cpumask_first(mask). The explicit check and separate branch
> are unnecessary.
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


