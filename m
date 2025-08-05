Return-Path: <linux-kernel+bounces-756252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19CDB1B1DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908F83B7CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705E26C39E;
	Tue,  5 Aug 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OeIrCZ51"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6426B2AC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389370; cv=none; b=tZh/3do1vYtWIv9QJWHlHDnkWY+6kfgGN0Fe5TEvDjKVAo7G/JZDU6cLzvVeBGT4DrgAE/a8HKCxjpshAuDnsptRp2ptaq+C+O8gPeTXqu7EG0JhkVjYEufVi+jRklrArM6Gjdn2g/yGrK+KjB73g3+pcgAkCjyvnu/yM8lpHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389370; c=relaxed/simple;
	bh=TE/mf/xUgkmdZM7YJFPytyu8Ro/YwJlxiywwFf1ZOdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO5uHeyoACghszRrZ7JAzcisc3eX4gghHmMKrASERDAjyk1u+E+pbEiJ9oKy5GvhSGGFTRiHpnVmwXzXrBJnLg8+xSmLrPvBiJ859WWwU6NK6rOJcepN+AX67i0n0p4mqLY99HcSkxxpYx6IT6iXqarbP3yRACL/9hTpz49/Gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OeIrCZ51; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74264d1832eso4934250b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754389368; x=1754994168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aK+vYOPbG3XIxjUyHmdjrcqGqe58W1i9+QVrnP6KWXQ=;
        b=OeIrCZ51O9+lp8R1k0lM9+e6QkEfPJkjbuC3ibCCazJgLl+DQyyQJwh5vxj0VMDTWp
         K8rlq3clbcJCbcbyVfWT+0jJQQMHKmajFuMDAfBeS7ZX/Y4Kj7XJwhGzUTc+EiqRgTKe
         vnnuBSYlqKKNI2YPyOWZAkZKDKVehQMmKr6ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389368; x=1754994168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK+vYOPbG3XIxjUyHmdjrcqGqe58W1i9+QVrnP6KWXQ=;
        b=jnTFVEN1Y7FZ3V+LO2X74budiWKsFzlnSUZeis66mH5Dj4InGaI2T/22KfnBuuJ/Za
         QB3lzAn9JQ1A3jJRC6074j2jMGrkNduRetEwzgw/Bb5O6vXwABD1kA+Qugt0fWgHsuuB
         tOPvDiVsl7l5Xc4F2VmeFSuZ77dv3BcPxkkqQJSsibYYQylkmg8FRs/m7XxbCBKKL2M5
         fTPzRi0lEXJQoxEtxLUiX0WCCYNXg6mI4wuN56EO+HW3f0/9ZGBKXSeL1lWwRGMouoSH
         4J/WdvGga8fdwHDsESPIpggoMOOjMkVzRXRFnbNajj18DvPcLgtJ9xDF3UlrBW/foeg4
         wQdw==
X-Forwarded-Encrypted: i=1; AJvYcCV+qge0y8v0tuTYOEvbQJ5lIwITLBWRL6Hlx5pFPMt7FtMDAvT+Q4EcfRGR3HugU0H+i9xJiIAG5o+Vcgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3wIjaaxC7Me5DNjvUfG7hsgEkKwlRr+WVJutONgYLIYRkcSa
	0qZGoKSwVCK2AQ3Do1AbCgglDvWrU/otBY87aMcHQriHX4okWDOu8MhjCPFmIRW1tDAPd0uzgrD
	gT38=
X-Gm-Gg: ASbGncsLcv5aDAss2lDDw2Ji4i6iOq+wSKTOB59pxqvJ0vX7UdxR6/gZ/ZJ/+B2bZvZ
	6AFcxJzRxJOGpT1d20K8SrYlBefP3jEHuD4mzHpT521XZPPyptvgDRgkOp9OHZz/lC2M9F8cvD0
	1U05Uzp/k9ayU4frI/tOTo7q3fDDjyB4hp7LmrK3yo0LQnHXkBSpZtQdtGHk2BeZWFajFmSuyfw
	w4T+UAOTF3Db4sHQifhY74IqBx5iaS4Mn/gXjC8h/fMPvl2Ny86UL6/oz6keMI13EBuAnQN6vy2
	sK2tgByA67CWNyOZihpbYr4bV03wEjMe5qBzuKhWvi9cybyTSZvJhLN1TNmG/qBIpslA6kE6eCR
	n0A0p/lPE0K99NpnZDL/hRL0=
X-Google-Smtp-Source: AGHT+IEqg2uzi8SDk/PQPQmMkBFwMwZgChILpKVD9G30iLBFDUPMSm4S+KYuTmnfrxnfYcPOBaCbAg==
X-Received: by 2002:a05:6a00:4c16:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76bef0e4c7cmr15395822b3a.20.1754389367914;
        Tue, 05 Aug 2025 03:22:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf5f7sm12635441b3a.88.2025.08.05.03.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:22:47 -0700 (PDT)
Date: Tue, 5 Aug 2025 19:22:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803062519.35712-1-ImanDevel@gmail.com>

On (25/08/03 02:25), Seyediman Seyedarab wrote:
> Temporarily add a NULL check in zcomp_available_show() to prevent the
> crash. The use-after-free issue requires a more comprehensive fix using
> proper reference counting to ensure the zram structure isn't freed while
> still in use.

Not without a reproducer, sorry.  Per my limited experience, attempts
to fix syzkaller reports w/o reproducers often lead to regressions or
just more problems.

