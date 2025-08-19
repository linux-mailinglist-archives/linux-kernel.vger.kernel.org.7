Return-Path: <linux-kernel+bounces-775250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37CB2BD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C818D3B92BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7831AF36;
	Tue, 19 Aug 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RylIOr5N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288B31AF21
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595150; cv=none; b=BM03yfWrcQiZGrJtrXAXN1cD6PbwnHB470yp21jED6+2leFxmfsXdQeTB8m4m7AiKK8FxpPcAkZYPxUKUObQEt5AGKXXVbC1GxysBB4AJVK7QWS6jqlTDLdSPdgoDDEkqIAXAGe6VCXR4wSWMMdyHmtQc52qulovIfxYaIyQMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595150; c=relaxed/simple;
	bh=PNZgkcdq9TZXxOPe5bvlFXYs2HJi7i9omPoA3uoJNAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCh0PYcSchBwFPVKdwZLl+AslFQ+tKz6YFUofA6cUKJtCg4il1zG7QuvJDn07Kz9gvonKUoGMQ4GaTzJddhK0CJ1PjJUxIFBhUl+PnWmiuJJyb5ETsGl+14x/K2j4X6W5LY6+9c9yT2RR05QhFxbr1L19RLryb94K+iFV9On5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RylIOr5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755595147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWT0mARngxGoK+lyzVNdKRI0J9MEuocADrq+/ReVQnI=;
	b=RylIOr5NYIs8Ze77+Ebw67UiAfTWPCHHXsyBgHDaScOmWWc3S5vtnnlq7Q3dsMrrOsy4hT
	pb1TjL18Cyyqs09Ek8Ajw5+JSZhsRHoYcroEheoX1SUOy396lLYT9qU3J1neBayPgd0J5d
	K0htRD7O2B9xN3tCCQNYNJdXdMyiwGk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ZW2bOVWNP7u8LTHOSGhdcg-1; Tue, 19 Aug 2025 05:19:05 -0400
X-MC-Unique: ZW2bOVWNP7u8LTHOSGhdcg-1
X-Mimecast-MFC-AGG-ID: ZW2bOVWNP7u8LTHOSGhdcg_1755595145
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c5457cso145402031cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595145; x=1756199945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWT0mARngxGoK+lyzVNdKRI0J9MEuocADrq+/ReVQnI=;
        b=rSqxmn25EEZuxT0FgkFyBGitiR50CRbP1G/+0cVQteE4F1xOIAC1Lmmh5iyNM+oAUM
         pumTYj1cJs9JkEQ4XXf6Z/EPIj0J1QdAHC/VuBNZtEHMXgSzsFvbroO64Q0ENjz3/WM/
         fRH1U7sTeRa3KQN8t/tfTOzA4cGxEYyv+gvy0XPHwjbqIfrzPjP+h2swDU4AAnSkX9qI
         Ex3PYMVMeHA/z5N9LDJaA3zBxpXrEGg+TGV1jYZr9w2tMhNdZTmQlgHRZwc+U1mApmMW
         CwXAryGOR/8vnbHpwO1KuvyccKW+ZRUCQBbUg/JEwzEuX2VFLDqXhr53IMH4P0ZP76Pb
         dNaQ==
X-Gm-Message-State: AOJu0YxCRWegNlrQsVpL2hYrvAmb9Z8nZGniq9biahtG39mbXZpeN9ta
	Ms5T/539oVV+8TjEfKvk4oZSygmB+rbwc+zKRlbI+o4gLwVWV7pKDhISQYWy0nDKJ8FD9RBxf/i
	07fwinKHvdxUF6kl/jvUfnDsqeZamwewmp2uudBF1dq5mrHIBsUPesSnKZuebFRHkzg==
X-Gm-Gg: ASbGncsGRvuoWlENXoZGC6taW+y2rIDLGyyfmkFNy531uZdT+fnZnDiI7Tx6POyS21p
	U5c9lbi1yDhJjr+2uCa0NBK2V+CDzw834RBpGSXF1y4jrZwE6dy891Tdm6Q9kvSXptr0GelCj68
	+x5RhZszF0EjIBoAg71BRZBhZPTZbpjKaEmq4UZ9U/dkyLUKuhX7d0uGjyUyksSbwtPcWVNX2Ea
	WAS7N90CoDkwoETK3gF/gvx30zqTYhtuTQ3Lq6aFlalQJWywYmE+pGQVG/ZdErPiUyfsotA6Isk
	bq9EaiimZAm+7if9IYLEQWpSVDeZUZnjNuR6+aPqZppPNWqQThFJW8TXJKJ/aAuWh+LG
X-Received: by 2002:a05:622a:4089:b0:4b1:2457:54a3 with SMTP id d75a77b69052e-4b286d64745mr20784721cf.42.1755595145232;
        Tue, 19 Aug 2025 02:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQlOoIPQxOJBoquQk0HObEu1BaMNH7ziz2yiaTpabR+DwR8fBQONFU8dJTuvHDGGTrWZ0nhw==
X-Received: by 2002:a05:622a:4089:b0:4b1:2457:54a3 with SMTP id d75a77b69052e-4b286d64745mr20784551cf.42.1755595144850;
        Tue, 19 Aug 2025 02:19:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb2d1sm63571441cf.28.2025.08.19.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:19:04 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:18:59 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Message-ID: <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-9-gmonaco@redhat.com>

Hi!

On 14/08/25 17:08, Gabriele Monaco wrote:

...

> +/*
> + * ha_monitor_init_env - setup timer and reset all environment
> + *
> + * Called from a hook in the DA start functions, it supplies the da_mon
> + * corresponding to the current ha_mon.
> + * Not all hybrid automata require the timer, still set it for simplicity.
> + */
> +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> +{
> +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
> +
> +	ha_monitor_reset_all_stored(ha_mon);
> +	if (unlikely(!ha_mon->timer.base))
> +		hrtimer_setup(&ha_mon->timer, ha_monitor_timer_callback,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +}

...

> +/*
> + * Helper functions to handle the monitor timer.
> + * Not all monitors require a timer, in such case the timer will be set up but
> + * never armed.
> + * Timers start since the last reset of the supplied env or from now if env is
> + * not an environment variable. If env was not initialised no timer starts.
> + * Timers can expire on any CPU unless the monitor is per-cpu,
> + * where we assume every event occurs on the local CPU.
> + */
> +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
> +				     u64 expire)
> +{
> +	int mode = HRTIMER_MODE_REL;
> +	u64 passed = 0;
> +
> +	if (env >= 0 && env < ENV_MAX_STORED) {
> +		if (ha_monitor_env_invalid(ha_mon, env))
> +			return;
> +		passed = ha_get_env(ha_mon, env);
> +	}
> +	if (RV_MON_TYPE == RV_MON_PER_CPU)
> +		mode |= HRTIMER_MODE_PINNED;
> +	hrtimer_start(&ha_mon->timer, ns_to_ktime(expire - passed), mode);
> +}

Does this also need to be _HARD on RT for the monitor to work?

Also, my only concern with the usage of per-task timers is that
reprogramming add overhead, so I wonder if this gets noticeable when
running some kind of performance sensitive workload in production (as it
was reported for dl-server). Did you test such a case?

Thanks!
Juri


