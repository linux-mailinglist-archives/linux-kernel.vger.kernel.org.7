Return-Path: <linux-kernel+bounces-876900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38FAC1CBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197CA5847D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74368302CDE;
	Wed, 29 Oct 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ0+Sibf"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7FE2857C1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761164; cv=none; b=HIsz6w984woedFgOTJoGEkkcgT4tSmKq+BBgC7K39SAvWpTDXUr6kd7iFUfgXe6t6pTonQb9SKFwZT56cqoFwjwB4t7LRvlOnFR5+tuzJEt9XeSEeA8J5kIl0wBqS71jbXpsRXY8M845pN7zaBT7cWTGcEItKzeA+TzIj57gpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761164; c=relaxed/simple;
	bh=kplIUKQ4OLgy88xSCJhh6Z2cBiPvKdIuelt/3TESWTQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ8lnw+GDd+CT/gnjvIgJYhxsl3Kw226Rupk0Px7lXhBWLLeR2yNMwmOEbHTX09QGoRvAEHPvbhneycn9mrGgdAQvVGDcrFU2EjQoGLFaltgqdkk7ZedvQ4U6Xi6mwQz1crCbMsuq66K35oujrc0znR+rkLatZz6HHXmex0GMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ0+Sibf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so784885e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761161; x=1762365961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=upVtUj4xcxhyMWz4iSku+76WitkTabZ9SQQIiAxfkXw=;
        b=PZ0+Sibf6HdvgO5hsMUizbneX5PEHYxlbnRohZm0dH1PrWbS2fRdylJN2CWKuJ9TV6
         34CgfC69CQ84Ii1GuiSTH542YebKHCRbhpQZKxh6mzrilWXxxr8xkXXgMnoz09JxILs8
         s7L5F8InzzRPHLL55rpau9b0B+qOvRMuVuyvie/BLzdGZte6ft+Zie3PXYft3FgIR2Ix
         XSNUKpU+SFl0ic4v8CCRUXMBbczlyLYj0FQvAzrThmkkPNXunEkkVuytOD6yZ4Pd0fu3
         BWJAT7ph2GDz0Xl4fr8For57tnnnoJeGYCckIHqJ+u6xdQuBtpHHLnHDO/W1xV1hvGUo
         lrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761161; x=1762365961;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upVtUj4xcxhyMWz4iSku+76WitkTabZ9SQQIiAxfkXw=;
        b=MRM2Lcbd/xqOuCegVbCWDR4gyeyLWXt1G2wPGibyYN71qBtmn7hTcDWLMUez1OGpQS
         zGia4YQjUXhfG9g6jLarRzo0WWQE2zwHxXsvUIF+yrjaZmHIBHZOO4fRm0YKyog53Vkw
         SG7vY0Ue0og2CfJtMKnW94ns6IWTQpFThUH2AV8fX9YSHf7QFBqYM/kayjyFTxsi4RGs
         t6QEMFzpzwipP3G204G/VD06WrtATANhTqIHF3ramch8eAJrtuwoyqVVdGz4YDoZYJTv
         L6kYzGAw1h7VPryU1jLKzIKa8ndy01JrfDgNQGmoJFUP2MJaGmxiI52ADc+/pNLPTXYt
         8UxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvU8NSwwjidfjyediM19j6fEn29A/tS1VgvoHUJT3vqJXeAEWpM7yR54kK2wxHtiRV7GgWFmBKipg1hmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/L48bJVE1t79GhRKaOJ9095mRI1eIMCmMsPMtdbY6g+fvsjd
	v1Up5M2Ieaw4i/ANFhKRzpj3MwSLTgNSTF9PN0I1OlJCC/mdPrdZE9CD
X-Gm-Gg: ASbGncsq7KV+Zd5fwf8U7ShvTnlUnPGr8+6byezdH7rcxl2o7lPwjBgkW4oR8wbOwzk
	RnGoR/9Q2I5OKl0VzFhN5GKvwMfQKha6RgS7JDqjFtWPnldsIggjPeEsQD1/ecYuvuCIPm4u4ap
	esNY/KpEieINSyWY2cebUK0UqvwgLa8o5ldYPQyrjuHM3YVV4CMBBnLRunje9jWOuBUZ42LtSwY
	/OKJHM96vJ7JjOwc9N0urJ2kYbUS/F/3AXdtN0RkKVTZcbEJvG89dV/yelR1iEAl727tW5zm4kW
	d62KaaVPXYd9yXzFpJAHOT7rRZ6mDCV3gGwzuG+QQslLPOhjzbLWCgWk3gjoXrFajGj21tWnqPG
	bSQ9uPjEjVETnhchO0oSjVLHEJFhfZscl3yH+eHGplupwpu8jwzpY8E1+hNXbdYDMvjBaXDxBVj
	RhMQIkHOcR4GwTgRVKubtEF11RxTvw
X-Google-Smtp-Source: AGHT+IHSma8oLj5Qa0sgTTL+xwY1TOAdclau3FGvNloE87sNG47vd222H4EzfvepAYTAqjHp0F+8Bw==
X-Received: by 2002:a05:600c:a08b:b0:471:95a:60b1 with SMTP id 5b1f17b1804b1-4771e1e2d65mr41964075e9.32.1761761161409;
        Wed, 29 Oct 2025 11:06:01 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387a14sm58442235e9.3.2025.10.29.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:06:00 -0700 (PDT)
Message-ID: <69025788.050a0220.36a6a0.16d2@mx.google.com>
X-Google-Original-Message-ID: <aQJXgyFkZYSNS_Ld@Ansuel-XPS.>
Date: Wed, 29 Oct 2025 19:05:55 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] scripts: add tracepoint-update to .gitignore
References: <20251029175720.12998-1-ansuelsmth@gmail.com>
 <20251029140353.58a4d6dd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029140353.58a4d6dd@gandalf.local.home>

On Wed, Oct 29, 2025 at 02:03:53PM -0400, Steven Rostedt wrote:
> On Wed, 29 Oct 2025 18:57:18 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > New tracepoint-update tool is not ignored from git when built.
> > 
> > Add it to scripts .gitignore to prevent including files in commits by
> > mistake (for use that have the bad habits of using git add .).
> 
> Bartosz beat you to it:
> 
>   https://lore.kernel.org/all/20251029120709.24669-1-brgl@bgdev.pl/
> 
> I already applied the patch and pushed it to my for-next branch. It will
> likely be in linux-next by tomorrow.
> 
> -- Steve

Ah! Well was too slow :D

-- 
	Ansuel

