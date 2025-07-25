Return-Path: <linux-kernel+bounces-746277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21740B124CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5404AE0C10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD5C253B40;
	Fri, 25 Jul 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW8lW7RM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F124DD0B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472328; cv=none; b=k4GXa4g7SoSWLpPBuexaKD5+A/WNkjRilAGNdgETA6BtHNSb+uhNGMSjx5zlPHpG54645labdWCgQByk9emK8zONsGkVvp62y40TeL+WQWlcE6YktTwjryNQbyjH6cSU9545Q92O59H7W8pgFHJbKKeBOBnfsn5kdztmXlq1Wc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472328; c=relaxed/simple;
	bh=RW0k82FWaN66w48hHqCoCFb0cqkm+Wk1ZZIoCZ4EN54=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=StCahzS0eQ50N4bR7KbKm2U2TgxRK8k83Vyuh0q2sS0SXvQlUpTUAB6hUHyRm6rgsmJdQJRMDblJ5bvhpUQ4EqPITWaKZYFUW+Ht4T2bvUPEKp8Uij748WOGh52SW6gmMpaZ+IgZktUgkBBdlROJh4TQn9er+wVOnXkmTv8zn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cW8lW7RM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753472323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8jZ2FtMapKFlfB2QCDPsmHYJKzRLnhgnwQRJqiPyL0=;
	b=cW8lW7RMtDkMT7do9A0sKm9cunKS2G1M7/WtSMkc477whZ0jWH/T2N0Gx4WpZpOeeUC55C
	ZPMGtD1IAZQoTdKilcsX6iZsogtj4mzIzvMLeqwTHEMjdQ9XDL2YCzG1OJ1NFtAD6/mQ9T
	ERALYT4agL4G3+8fjWiUdBy/EIpEU+M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-_FR37c1nPzyu5WzBs4WWSA-1; Fri, 25 Jul 2025 15:38:42 -0400
X-MC-Unique: _FR37c1nPzyu5WzBs4WWSA-1
X-Mimecast-MFC-AGG-ID: _FR37c1nPzyu5WzBs4WWSA_1753472321
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70707168c59so21341596d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753472321; x=1754077121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8jZ2FtMapKFlfB2QCDPsmHYJKzRLnhgnwQRJqiPyL0=;
        b=GEHDJ/lFUt769D+7cfk3XqqgzIdoIU/xBhZ9GoCH7hUB/zEW39TmmNv9e4HobKHPuu
         S9JX+rUpv/SssUjzzm+26Sza5PhEKrOqS8luH+QGW0uRnY8l5CO37H37qSHFt6fLKxwC
         EcNYqKaL+n2bDrsIS2LBgGVQFXLJsmxTDVluOS30cTxBdJba2+w7O0Srb9vGb47S4h1L
         HVHU5R6ar3MGWLv78i978mfFaplcnMpuNSVRiwwqdMb5iWGZZJGiwPHacGT14JswQ5uc
         t2O0YHpzb1y5WW1XMx5hgD7u8nr/WxY/6eTji3bd74SgnrOUxCYPzJkFmyFqMI+ot9fB
         dQ3A==
X-Gm-Message-State: AOJu0YwuZPypZOiiql+fUUH43hT8OZ7nu2aQDNkE/7Ze3Uk7X3QN7lNY
	aYNzsXgZ7kkethPcyst4669fephO+ibftB29iO27l+nNrIRySMe1AYKlmeXvOAFmX2KDgK8yKUh
	D0ZdPg5TfWAeKNW0e4nTnZ4+p7+Daq/wivKQxTu26CUqKlrQY0/BgkRxB4FQrwpik9A==
X-Gm-Gg: ASbGncv6iEXVnUmRo9PzHPFXwZtqEAIr8PEXJ0nJgVgb4Gd01/W9ayg9+KbZ7R9e4bm
	qUL87Y7V1cEqnI4S4OIhpdyOnnIvz/A+LNHf1qlPaVarVvZ3nrybuLzuKZqqb1Sx4iJ0px8qEus
	ntFN77WyN8aJg852GD3pOKtxk7i46V1iX9+nAZyl2UpH+skouu6uVcUwjlxEq1ntKt3OruUAQa3
	yGQBgZd2zLwopP8EN5R5fchTEw7ouhZR9kEBaR+ENOjm32CTvFtm6dxieG/QAITESysD0+6K/ss
	Bcwj0T8q6l4UJKYDeqQfFLvRcwmIrw+rgaVXVtYMt0xXNO9W5iVLEBGnE/PGgVEi6qjfD8S0/Jf
	J/smTZHYG0g==
X-Received: by 2002:a05:6214:ccc:b0:704:9b27:1161 with SMTP id 6a1803df08f44-707205c3cd3mr49776226d6.40.1753472321268;
        Fri, 25 Jul 2025 12:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7xuWEXOSCH/T41cv96g7IcqnoTbp4n25zJN0OOBNxKF1Ug9NWq88qiGpSh7Zmzhxivjw1nA==
X-Received: by 2002:a05:6214:ccc:b0:704:9b27:1161 with SMTP id 6a1803df08f44-707205c3cd3mr49775616d6.40.1753472320798;
        Fri, 25 Jul 2025 12:38:40 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff109sm3812486d6.10.2025.07.25.12.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 12:38:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c13616d1-b11e-460a-8eda-5aa72c9123d8@redhat.com>
Date: Fri, 25 Jul 2025 15:38:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 John Ogness <jogness@linutronix.de>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <848qkdtlsl.fsf@jogness.linutronix.de>
 <6a27ffeb-a79b-4623-9ad3-392973a1fcce@redhat.com> <87y0scpepu.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87y0scpepu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/25/25 9:44 AM, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 20:16, Waiman Long wrote:
>> On 7/24/25 3:45 PM, John Ogness wrote:
>> I am sorry for confusing conole_owner_lock with the console_owner
>> lockdep map. Yes, this lockdep splat should be a false positive. You do
>> need to put the mutex_acquire before printk_safe_exit_irqrestore() to
>> avoid this splat.
> No. The printk code is absolutely correct as it is.
>
> Did you actually read my analysis?
I have read your analysis and I believe in your conclusion.
>
> The lockdep splat is triggered by the raw_spin_unlock_irq() in
> __flush_work() as it makes console_owner unsafe.
>
> Again:
>
>    printk()
>      local_irq_save()
>        acquire(console_owner);
>        con->write()
>          vt_console_print()
>            hide_cursor()
>              vc->vc_sw->con_cursor()
>                fbcon_cursor()
>                  fbcon_del_cursor_work()
>                    cancel_delayed_work_sync()
>                      __flush_work()
>                        raw_spin_unlock_irq()          <- FAIL
>
> The initial report from
>
> cancel_delayed_work_sync() _CANNOT_ be invoked from atomic contexts,
> unless the work is marked as BH work. And for BH work it cannot be
> called from hard interrupt context for obvious reasons.
>
> Marking that cursor work BH is not helping either, as printk() can be
> invoked from everywhere.
>
> There is no way to legitimately invoke cancel_delayed_work_sync() from
> the legacy console write() callback ever.
>
> No?

I am not disputing this.

Thanks,
Longman


