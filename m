Return-Path: <linux-kernel+bounces-857832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67983BE8083
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EE72565CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7C31196C;
	Fri, 17 Oct 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PVsWUASy"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDA311C0C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696210; cv=none; b=dTsNH2gykP+QAi5i8tLSDmvgpJ/VQQQgOnof0RVTBiuSBqvvrNZ8BiFRTQikglbyvIZI4S/d49SCLYDyCicnlHtx1WDrJlMCRS0ZnuN3/3A8tD7Zzu/eUT8xTzgVn9a4heNYralRGtOu2laTLX/BjmO2VtOPuAylqPvunYkC5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696210; c=relaxed/simple;
	bh=I836Jx7ng7b74q0nHzD7V0nJCzbcpXcHIt7EkcfoGCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m71TUmnZZDxEfad5PDeul4MBwGLF82QCTfJktdWCTrJYipq001/NCANCwVgoTXYGs3B4cZqQ9VAzczWAi0TBBN/TTrR8oEPkhRZhIYkWF7QlpJoO+Olv09vcTlPjsQAxYXPE+v8jx5vq2F3KXf5C2CB4xKDJQs03lpcpQrY49WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PVsWUASy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47121d6da31so61005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760696207; x=1761301007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viS3DvrDA7N5filScWTdQ7ckK4IythNKZ1IY1FtODKE=;
        b=PVsWUASyOoF9E309yU3baFgnMiTzQcSI48L1za4wNEJFCNOvw0TIOicJ1b6buLVq+u
         HjQXPkxLFDYJyEtmfVql1KRq2YOSG5TcEei/k0H9cUOaHUEVQBdz5URiF0N//vBdutqR
         PWS/6pQCZTfkUazqxmsH0765u7zv+Le3+ni4f8tSJaN/gaYT9pN02lZ35xXuYaGMs4hE
         vJZBDEJAVqc185L7PHQ3lPymIJWlsI0I35YMcMBzvtwOoMao6Pjo6UioBD7jCHGnSwaE
         cLT85EOMHH5Hwnml+ztx46VI/oulP53EsGypASyKqfGsuz8GA9VwusVgNAmVToIZJKa1
         1oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696207; x=1761301007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viS3DvrDA7N5filScWTdQ7ckK4IythNKZ1IY1FtODKE=;
        b=SlcpiBPmMtG//NLUjksDW6DUWo5FN4hQbJ7/XZ8Eu0lDBR5mXU4oUGQeUaKE3PjPIK
         gOJvbUKXMlnEfGP++M1bHV7ii9ebpeeskUCYsod904V37jqiSQUSc1Y5pg+Ql/1NMZNe
         bYcEUYM0yGF2382A6jZk6R18jIkDVBImC/r3UbtoJshVO7keMgpEqhnl+p6MZWZZ3V/C
         dCsf/XFG//d1AQ4NCU7iwGqRv2e4w6Ev364J/3nD5X7HMB+9B837avlke9+5G0sIbFwm
         HPLOAwoY6doXzOzlVVKjc3VpMT0btuUyJiGw3Jdu5vhf4rjZyKpyUb+OnIQZcM2q3wry
         Hmxw==
X-Forwarded-Encrypted: i=1; AJvYcCVoNa3WenChdt/Pvgh8DQ0tSLVziRUgLK8PB9oM7NuuzM2n64bi+nsXPXiVLBgCSoltrtUfk7cJCnqD67s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyCqAEsrzWu+QtqpAQYyc83SOSLXC1Zs4FjVb4+YY4t4yhveN
	oJiZPXPdH42/HEh4TThsvQqIJfNcbTkWoJ1pqgrtxTij8Glmz35Rt1RXfZMA8IaXrR4=
X-Gm-Gg: ASbGnctBJnsoOrbUNy6G43km8ltL3UXgK5mBOw7KL7AFEx3VmRI0Vo6MaYH9xIu8vBX
	80D4f1d0/vgoL5vVPPSumVHoBj6QAXEzObHQwaiANlQjpzmwLB/NglNvsC0oOi5BLyuAs6FjLJ9
	3Ajg7B1RcuTXi14qxdfuD7SsvXbUHkDd6ZAlag26a7cKL+aePVrH17a/Auocl9b1RrByFRxZa5+
	9nX89Jf9G1Cik3kvce1qm5qvB0Z8Vls3rzSXcIFleHGU13agxFkZCFLoO4IU3ZxOWdpQkK4J1ZO
	6K5wtzQi8pAb05DEEfm3b23Vfx4UAPE0nZKK2GD9x+VmL9jVNCptDECuVeBcmsmQUv8V5edXdJy
	roiPiTK0HPuxyD6zY37v9+XUF+dL7Gr8HtBtE/HbJhNiPRQlJJ3pLzjPRUJaNG3CIA7KbqZvINg
	6TKbS83/7sMvaeMcs+MpWWWSXD
X-Google-Smtp-Source: AGHT+IE7d1EMWBKzTirDjA0j/LBzhttirmBc5/YxJccLDP4Fy1GVRsRF9OdyLro6dqR2+G+508ivXQ==
X-Received: by 2002:a05:600c:310e:b0:471:1645:458d with SMTP id 5b1f17b1804b1-471179122ccmr20917295e9.20.1760696206670;
        Fri, 17 Oct 2025 03:16:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cc3sm6585051f8f.9.2025.10.17.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:16:46 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:16:44 +0200
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
Subject: Re: [PATCH v6 2/5] printk: nbcon: Introduce KDB helpers
Message-ID: <aPIXjPJmJxW2i6xr@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
 <20251016-nbcon-kgdboc-v6-2-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-nbcon-kgdboc-v6-2-866aac60a80e@suse.com>

On Thu 2025-10-16 11:47:55, Marcos Paulo de Souza wrote:
> These helpers will be used when calling console->write_atomic on
> KDB code in the next patch. It's basically the same implementation
> as nbcon_device_try_acquire, but using NBCON_PRIO_EMERGENCY when
> acquiring the context.
> 
> If the acquire succeeds, the message and message length are assigned to
> nbcon_write_context so ->write_atomic can print the message.
> 
> After release try to flush the console since there may be a backlog of
> messages in the ringbuffer. The kthread console printers do not get a
> chance to run while kdb is active.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -606,6 +606,9 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
>  extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
>  extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
>  extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
> +extern bool nbcon_kdb_try_acquire(struct console *con,
> +				  struct nbcon_write_context *wctxt);
> +extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> @@ -655,6 +658,9 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> +static inline bool nbcon_kdb_try_acquire(struct console *con,
> +					 struct nbcon_write_context *wctxt) { return false; }
> +static inline void nbcon_kdb_release(struct console *con) { }

A test robot found that this definition is using a wrong type,
see https://lore.kernel.org/all/202510171023.YREXxhMK-lkp@intel.com/

It should be:

static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }

No need for v7. I am going to fix this when committing the patchset.

Best Regards,
Petr

