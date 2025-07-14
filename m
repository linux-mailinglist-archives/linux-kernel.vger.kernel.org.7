Return-Path: <linux-kernel+bounces-729330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478AB03509
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF09189708A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310C1E9906;
	Mon, 14 Jul 2025 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q364Wf+4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1B1A275
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464369; cv=none; b=DX4RXWyYYpOKgKUQRxet3CMlOTcLv3TobRPF8fBb7a2GDuf5wHzecy98NHAi+PW6/ZDZhoCd8Qjk/qzJmk1izRzQuZTA3CSrqkprMqEoKOxNLo4BxBfQOc0DCo7nuq4XHHdqyNLrxB7NHUkJ0dT6c/jbCTOLhKmJS51A7iBh4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464369; c=relaxed/simple;
	bh=9yw1cM1JJ8Ap1pjgj+U/AwSkrqjRXzvfTo4MgmXrsx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzIg+wVJpkrn/xwq46VjiTX5HczxsxGm8KnH1dN1CGx1bGh/zccFGZfZUjL/Sn/TtKpm+D/3Clddx+gYUMrA2Tt5EFqLFwWA8xiG/xPy62hJNe7dAOKKgPbRYbbiEBX5a8eKYlHMvlV82G1bkEXdMDDE+kcp6zGUvOleRWFYUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q364Wf+4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c8a505177so35053995ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752464367; x=1753069167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+6/k62UI4QDNnsPMaNZviv8mxGlHDTuu2KNG71R0NE=;
        b=q364Wf+4bcQ0z8XHkCEMMPAI6Gc2Ww/IWrst6K4NHkM9C/8ctpSzX8S/BnHwQMCKcj
         Rnr7kvjr63FVRGvmkyrGrSSMj7jyE6Uh8u3QqWVpOyZjJ07vElv4H5zfOaLr2VhhOQ9w
         ufHF1J879WoIlJ1tNB9frVQ+UDDv4m9nTbNqSHjzGgPpcUNwhi/4WTHhLtPQAwQKl3SD
         GQKnU3mplUNfx+g/98Rak63lULQFjzdS85ODW5KXOzPoe8a2o+ADn2FZeXp12BIw+VvV
         nJ0bFMy6V9KoARbILe1jxFk2rgbpaNZSglUaCuWYekJ4WwY081glZ+vM8idx3lsdeRxp
         M1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752464367; x=1753069167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+6/k62UI4QDNnsPMaNZviv8mxGlHDTuu2KNG71R0NE=;
        b=sCrYUz0iHVaPXLx08+9q+2o+Kl1Yy9AYUndp7ShE062E7d563z6pDSiOUbSLa17RE5
         GCtaI5VgxqSVvnHH+54fXC2qk+8I4D9gk4NQTWPezN1XuJc+rJI2rajRkvqwcgK+p8sl
         5o/0cuzmxd1hhl5BhyPxtFMnXMDUrKW8fJd/cG1zpOwMNkassKbXBhpO5Mc4WsK8N/GX
         ei09YB5vLQi7EeSPw/gBpYfG1RwXKP/BFUFtBpt/UqihKey02FHDpjaxirfW/kIxQpu6
         xk67X1HZUQHcGKcEh9MMPK9KdYtF39UB5fCUgbJlYVEjmj50Jth8LdwTooNa3izz/nM+
         5x6g==
X-Forwarded-Encrypted: i=1; AJvYcCXOjO7hLk/s08SAG7azIGrpdmu8WBo8TWB/V9/5hm3pd/XTnTjbmsQKgpuEyfVESKkjTjNB1BgsLVJtV+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7paVLs1nTRd8V2Nl/zFRoL61GSm0lMoS4NcDs+IzKzuIQwXg
	QEhHma2Ax7VC4RYZupTYkkZ+T8WvzifSlzgOePHaGF/OAlcCZkgdz8AbQveYwiahP/g=
X-Gm-Gg: ASbGncv9PSXuYFQcOhxxu/n/Jla/uuks8Wia97GgJFo4iw0zVfDJA6IxQMrpGfs7bfX
	IiWnxzvppRV1iGcsdY7vcN7t2UKNU1/jQ7R3F44LmUntzKvhjCSWp6yROXk7jtiEnqWJhBhdhQy
	HoCzeFrLcQnJ0roeI+7zMluk/DmDDC9I4XZ3lIUe38gDseCV0qbechf82hJSlbfJqOch5gEwto5
	DpNb4PCvlxDKnxp6Yh+0QJEP7nslQ2V65BmnATa58zKRm7xKpXrM9QUTZJtG5+pjDDwD0ch/5Bx
	TQQFwXpClHMhRTSdXwAyakIjG1MdN+r+QW7y+zHNdQWCzQqgXyE7koGy5h3L5xI/ek3hdG9rjhL
	J6s4ePVfGmkjsVMIBVyDFuJc=
X-Google-Smtp-Source: AGHT+IH2g5qmc9RE+Cl3rwDnpBl4jF0vwTsbg5rxmEj55bIQb34Hr8YQz/Yx4gWK6dStNBp+qFIREw==
X-Received: by 2002:a17:903:a86:b0:235:91a:4d with SMTP id d9443c01a7336-23dede58855mr153362665ad.23.1752464366767;
        Sun, 13 Jul 2025 20:39:26 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b0e04sm81449905ad.84.2025.07.13.20.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 20:39:26 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:09:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: virtio: Avoid hang by using interruptible
 completion wait
Message-ID: <20250714033923.uoyehav3sbcb3rqn@vireshk-i7>
References: <b8944e9cab8eb959d888ae80add6f2a686159ba2.1751541962.git.viresh.kumar@linaro.org>
 <pvjv6gn6ylnpncdp5xdzt5wdnzc2tuuww3ihed46q76vm6qwly@7smel4x243a3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pvjv6gn6ylnpncdp5xdzt5wdnzc2tuuww3ihed46q76vm6qwly@7smel4x243a3>

On 11-07-25, 16:51, Andi Shyti wrote:
> Hi Viresh,
> 
> On Thu, Jul 03, 2025 at 05:01:02PM +0530, Viresh Kumar wrote:
> > The current implementation uses wait_for_completion(), which can cause
> > the caller to hang indefinitely if the transfer never completes.
> > 
> > Switch to wait_for_completion_interruptible() so that the operation can
> > be interrupted by signals.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Do we need the Fixes tag here?

Maybe we can add:

Fixes: 84e1d0bf1d71 ("i2c: virtio: disable timeout handling")

-- 
viresh

