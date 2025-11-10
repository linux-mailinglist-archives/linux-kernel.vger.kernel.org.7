Return-Path: <linux-kernel+bounces-894062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36280C492D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B973A24AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31B338904;
	Mon, 10 Nov 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0MMjHYL"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C52DEA80
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804940; cv=none; b=QzIfQtxqFqd9JQXX4eT5Jl/n4kqQU4I3m2Rwu8S+Gx4VTPLwgY14phr6oJk3X653eHaQs1OMTYJOw8w7YRK6Z0bTx98iGTcMQIoskt8ZUeLV5ur1zjgxw0JlQMudZjuH7FS019Y2yaNldbbg+a4OK3WTiLxTMOCwpHM2Q87uaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804940; c=relaxed/simple;
	bh=WEbUCqKPpqNwVY1zEPDo64sJfZj+DKjf0qTpZ5wdgfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsKbiqNNDHoUelJnagAqNwMH3zCOQt/MwPb5F4y5JqV6D00TTo8wa9jn2ZCzurMlSnUDl8zNs9yVp0vPpPxdQPEpqniMhXI+pvVk8+AJ+LaTAYYUKLXGUqOB+F25sC/nYa9Q2v5ByPl3//3dsDtgqRh4tIybmx6mHnOKRTUX4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0MMjHYL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b98983baeacso1355933a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762804938; x=1763409738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NLYN6jTBEGwmHxj0J2TeyxS9PbPiD4fPo/j2nnYR3E=;
        b=H0MMjHYLFhbaiGud6XqzQNAlgdWZuWDFA1MdfQjuaI4XTFwkbEXIkeuK9swa3VbLgl
         P2NluPnBZSgQ7gI3Ir6904KbVN2DSCr+FsH+ftX0M9/kYAuRpmmeCWUusdhK1SEiNjGC
         0H+Qs6+xYj/xDN5KGTx3nZ8pnLtc+lPOYS22nnkz5if4dILv/6ZCp6eXv1OLiZ462ur1
         j8Wtjz3XJlSk6QI2+QnnivCKcrbL4m/agB9f+aQWDLB+B/IrXiSQn6ni5a6BcX2kWpNk
         IYk8uoSofJc91BfW8koVHNTqCSvoUZEh8FMDGu7BRsY5/bH7tbFXW/JYFWfH4SG47oXU
         FvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804938; x=1763409738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NLYN6jTBEGwmHxj0J2TeyxS9PbPiD4fPo/j2nnYR3E=;
        b=LDQaLx8rAlLJ518miohC5IvqtMP2XcupFAoRKRdW8gI7sC1KA/U3ysUEPIIvNORjle
         mRknnvML1bUNNhCtOdd3XPknJGlVNoRHc+6sNXd3pfbkMeTdjfqD202FzvlGFUpL1vRV
         GPTWTS+Xgi147k1sK8ECFhmp3JIrvDBfwGEgm/mdNEoI56w5N2UqXTn9rO4wvdc1OPjV
         bBJ3ZhlqpQ0gHWljvbEb5o7JsDe17kfHOJg92yII4WphEWuG/AJmDD7xiDpc8DudFODx
         q+hsW3HamYEHe9Vi6Lj0BswQBqKHNzGH+ynj1p9HkkgBm+Uwrf+O1jqfalmzhZqeHlHx
         bTGg==
X-Forwarded-Encrypted: i=1; AJvYcCV9YI4WKoZVCwvR8GDi13zg1dRS9UlkQ5atEVFVGFQ5ypQshld81R+TmNiLrGkOsdIYhUQ6Yf5exyjhNis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkwP4XtpzAdgsSa1vpL/bHRG//e6XC5Jy33aHVIAsKyMyyUM8
	UYPGNasM8krqmMZ15Ek/0hGm9r0JJZq9a5kAZwTQO+BmhihSzeIyVP2l
X-Gm-Gg: ASbGnctJOI9cwOF2XY6FUoRUPYiuhW2Lhidu6Cc7ULDEiluTqh0QJEwG7MOiAypEScn
	uvTKNFC98JtcoZ8HvgwNQqNDJTimPYBk183F8EowaKVkckXy8gW3EVVnW54uK0ggPDAAUtEaeko
	BGry8N5qFeBDxg+BXjSu+Xli4eZrU051b4MoUnpu8FDhL4xLT1IEkX7QeVOG4AKqgp7cQVuv9M3
	18c531l9HvCfhrSSoKE58JWSuFdJOfc1o7PekoHLbm0TnxmxOic99O8iymKYGF6u6BXRqTKxhG+
	MRup3rWCzVpW+U98/DSDOlsHRXz9LIpFxRKEPWvAZ15wWTZXzT3yELFhVm1BJyr9OCNhMsecNut
	QBFEnqF+d/sl6IirL3HrYOBFHTtFo8pu6A9r11w4BMcn6BdTnVEGU/BN4HL//u6JIbFvbKsH/js
	yZnvBQ5w==
X-Google-Smtp-Source: AGHT+IEx5DrKUEdpyrpancufPKZNJjbcQnhJSxpDOTbqT+ORySyjiLg4DxwBtCBYpfTv90p5Dx8iQQ==
X-Received: by 2002:a17:903:1a27:b0:297:ec1a:9db8 with SMTP id d9443c01a7336-297ec1a9e0dmr131667795ad.49.1762804937650;
        Mon, 10 Nov 2025 12:02:17 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:9974:abff:f64:1199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699c011sm18596997a91.14.2025.11.10.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:02:17 -0800 (PST)
Date: Mon, 10 Nov 2025 12:02:15 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com,
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	khalid@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 net 0/2] net: sched: initialize struct tc_ife to fix
 kernel-infoleak
Message-ID: <aRJExzyyqdt1V6cP@pop-os.localdomain>
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109091336.9277-1-vnranganath.20@gmail.com>

On Sun, Nov 09, 2025 at 02:43:34PM +0530, Ranganath V N wrote:
> This series addresses the uninitialization of the struct which has
> 2 bytes of padding. And copying this uninitialized data to userspace
> can leak info from kernel memory.
> 
> This series ensures all members and padding are cleared prior to
> begin copied.
> 
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Looks good to me too.

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

