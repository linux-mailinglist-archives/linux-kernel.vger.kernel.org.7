Return-Path: <linux-kernel+bounces-775584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BFB2C0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2878F68234A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C61932BF45;
	Tue, 19 Aug 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wf8ybFHq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3448202C3A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603920; cv=none; b=ZsbcZMclAswGyZEPw+q8QEBsXorO86gPIT0Ahu8QbxALH3LakiVrTc7515bIjHvSnbcgb8GFxlgDjToH5nUyku4dEYqw09amJ6vRAbB1+PF1ho051gdRw5Xq6PhctsP9tSazTqATwPTZez2ITZuA1CvzS7qnOKsLgTvql+8sOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603920; c=relaxed/simple;
	bh=OhYimyhkU8xUPqjfvrEZkz+wuW+OLQcgIGL51RQgFI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u9lNuGkp6F+bf+TRnsm9dRGYOq0V/IHiToGCNxamdxf6imESf2NKbQunOFDT5l7qFgsrYTPWo0bNUcNhffAyFr79Y1OJVoPDukFz0cg90noECT7JnsgAh6HgIADR1MRn6/kpt3ea4vcZJsUiCWge1c1NdPH7Cd0q/0WKCDZHHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wf8ybFHq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755603916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OhYimyhkU8xUPqjfvrEZkz+wuW+OLQcgIGL51RQgFI4=;
	b=Wf8ybFHqhZoi2ABpFbgTE2LwBQ72i5brsH8cyNUZdri3kyvYLqqr19O5pwuul9IJE1Zfwr
	Gmkl0sKbhhD/P2vQxWSBkSiqSf/TRzlqj/JA7l9LoPSYm8e504QVAh6Bzh2gQETCCmPHan
	Ok9xkjdlL/h2Q5hZ107r36KjXju8Z1Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-bJuW4UmANbG7pvZV3MZj2w-1; Tue, 19 Aug 2025 07:45:15 -0400
X-MC-Unique: bJuW4UmANbG7pvZV3MZj2w-1
X-Mimecast-MFC-AGG-ID: bJuW4UmANbG7pvZV3MZj2w_1755603914
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70bc9937844so18487666d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603914; x=1756208714;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhYimyhkU8xUPqjfvrEZkz+wuW+OLQcgIGL51RQgFI4=;
        b=UJKNQvTkUf7WYAbgZXUuMkkn2iORBJOJvofhzWd+xzEtZ1uCoK3Rsb1pNSSgDclKih
         g7FPvfO2Ni/6YWPRRqDOew/Pf2vTAwfoAffB0xP1R0hMMfbQegtc4qLbqgHyvGVOAjQW
         auH3uO/i0ClFbkbQjpZ0/zgNNKfi9NpoJoiW/nmAIOXJ3+e4aHBFK2qNofYBUoZnoilB
         4sxKafoDA8vgh/Cznv6OxipLx84TMUMaNPfBAF4X7cuuO9dAm8GrJ14+vfTJZ9es5UEK
         +ycLpbhRyTrAX1eXO++0hFQ+6adprlakXWZDhqL6C6zGAOCMr1MABhZP/b6alGBrAjHm
         z41A==
X-Forwarded-Encrypted: i=1; AJvYcCU9I3O0jMin65bPfjEhVqHBdJfofWyObEr1kTD75PZPZfFpFkPUGfsElOzB5BJDXWPpAq8u4+TUl5pdTrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUzLuV4EiGWzu4WzF4A+hgTAm1TfcDnxk7R2FD5fMFX2LorZE
	5lXToct67kC0ABvPUnxvrgNNs7tdm9Q/OgE5iv1D+3pYlDxJRa++WtBV8NijHWOixxlFAMS7TEq
	LrnZWMnM4q1d3BURZPRJif8kg+Iff7BwXT8fvPfyL+ZyyL1GY7Pc1Kxg3BdGcrUYqVdTbYF1pwQ
	==
X-Gm-Gg: ASbGncv7mV2nJi6BBsw2INEvYQrf3D3WcKwRZqVoKYCAq3l7OZPNHq+0Yrt/0YZEYPg
	SnWxXu0U9GgwMORjnF+Vx9l/E+8y4nXUKLIIBzJSO7P4CXth87cf3pObUb/0834kgbUII/SumwP
	HkrV+SPETnqmixZ+4nBZdxS0hvH+oniSbDDLdjCd3PnQ9op+pwdATtVC9H9Q7TZeGIQruOCzBda
	Z9qDDdmqh14fF5ZWvRfh1i2g/AmBC7w2l0Wx5XToL3okaW5g0h3wOWKYgzfN/Enkq5a3BPw1ifs
	txoJnq7NVeUvX+Y8kBHpIMogHX0l2xawqOfZ6xQVe8FWsi/rCpW762KUKIOjvKegrzsh9AhIfbR
	id+6Vvzcc/0RavM57UW20xqPp
X-Received: by 2002:a05:6214:4102:b0:707:4628:3e72 with SMTP id 6a1803df08f44-70c35d70aa6mr26958436d6.45.1755603913386;
        Tue, 19 Aug 2025 04:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7XfqlwLEl3jRrHjFoCPVaQIPMfNtmYayv46YldCJMndbHtc/8o504844sW/5mJYdNiixJUA==
X-Received: by 2002:a05:6214:4102:b0:707:4628:3e72 with SMTP id 6a1803df08f44-70c35d70aa6mr26957996d6.45.1755603912904;
        Tue, 19 Aug 2025 04:45:12 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c10f2sm747938785a.59.2025.08.19.04.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:45:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: lirongqing <lirongqing@baidu.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] sched/fair: Optimize CPU iteration using
 for_each_cpu_and[not]
In-Reply-To: <20250815011512.6870-1-lirongqing@baidu.com>
References: <20250815011512.6870-1-lirongqing@baidu.com>
Date: Tue, 19 Aug 2025 13:45:08 +0200
Message-ID: <xhsmhwm6zh6wr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/08/25 09:15, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> Replace open-coded CPU iteration patterns with more efficient
> for_each_cpu_and() and for_each_cpu_andnot() macros in three locations.
>
> This change both simplifies the code and provides minor performance
> improvements by using the more specialized iteration macros.
>

TBF I'm not sure it does improve anything for the SMT cases considering we
don't see much more than SMT8.

The task_numa_find_cpu() one I do agree makes things better.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


