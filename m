Return-Path: <linux-kernel+bounces-851200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13085BD5BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3807E18A3DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630852D6E7A;
	Mon, 13 Oct 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gf9WAom5"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549519E97F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380818; cv=none; b=kcTc88lqz2yHWQiemKEYnD+ku3wxc488T5tbEBu+j/W82P7b0l47TrxDpeoAv1LZ8YSMcUPjcVune/fq47U/29kD12itE08H9l5nTo6PeJJfCwLfOitBwqxzfU0czGYT/6TZHiQWW4LhVwl+cWJbp2X8y7+0MB2KJuZRsLciAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380818; c=relaxed/simple;
	bh=fvEL5X0zqBk8iunM0o332HEpCMC2w41HMd6F1GLdjjs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SZ6IP012MrSGJsz+8uQgT12BgLU7JDGZRzxiORJKnwIus4AEXpAcplGV4wKnuEmLJfLJC/VBjH/DJSpYds7u9+qQOsyo8IPAcwgxJYBdXdnmtvh2NkO+XX6xMLeeEKOvxvkHkqExjBuTjgy3/RBOebNF+xPWOmR5TZgaEzJMcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gf9WAom5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-80ff41475cdso92454366d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760380814; x=1760985614; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otoedkFMmi73QYZCpNw6QjUVY4scWdaY7ZmK0AImrmE=;
        b=gf9WAom5qrLuppoOp57bEJ5Fk09Mad23/qpxilBTOjm69LLrMJ8oUVJqxbM97Rsypl
         554UdRx4XXLpoIX/MdzmEs/sp4FXMYlr3ehQYWkb/3KvuIEY+2/2v6YAtpXc9oSlc4EI
         yZ70tPCQPcLL/x+repJ1vNQRixS5ELUElsg+oiTxVRtzLUOvt99mrpdCeQ6sDUIxmlmu
         gjcSAfyXzaM6AXPHwUVEIIh4d5QtMabxIQG+NDCQQQbVncxfCqae0PiJ1fzF+wxmq0p0
         0uXIyJBZVb/GST8hfkXgIYZ6Fqwj0NNW1VjRhhCbEfPPxPNhcdn2E+ogLmLNujTPd/aH
         lnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380814; x=1760985614;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otoedkFMmi73QYZCpNw6QjUVY4scWdaY7ZmK0AImrmE=;
        b=w09v16O9eenLRnadQXP9MuCcxNxY/k5lZPzX2JADznyZotQBb50yrsovGuE1qndvIc
         V/tagyPSA5I49aBwDxw5fUe2IDpsfPJ/mXmH2zd1MU3iSUmzN/6TiGydxReJoBDrZDGi
         5KsMgmcESuxTNeAfTFNXWD/aywz6Wu6mH+DvjUghVhb4fsQjGuFBZuGt4K8TVUbRe+UO
         p0dRZiYMM/+8KKSBJqYVYawjyxUj2pcCQ5HPACBdZBFB9+ct5UkPEccgSS/XXq/dFB1J
         kkB628ml7BgUSCOodNErOvLEzRudfLRTy4xlPQ5NJ5tlcoz67Oz26UsbYSBESNemTcIE
         iJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVscWP7mLf5HPQJQLo1pLa1FfF/RqiaeatKF4dBfIbVeGA5r+AfB3JP+t89kKfT5BuoqyDMNQar2wDLLMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMNiEJpPn4DntUqqZ6Cm4ThmWo4RdyfZBSuavinJFAH8ODRNj
	RUIB30WCs+l23YqUDU1oRlCt8o4MNpU3UUbDNaKC/iXK/yun30iHC1EBdq6WJq/ckg==
X-Gm-Gg: ASbGncs2i7e7C0Pd0Z21FIQz9rn4lQfBeEItTSFjJopcvay2eA68ZTrtArBWfmmjMtw
	UtNb1SITT0/WX4eRGhuouToMH6bkfP6QsYcvLhE+e1gT8AUp6vPIGwlAXv57BlVWEYz+HsExBnr
	/qTFS6bcI+oex5Fgn14ujUnWLeEq6NimC9eLc6EmHBjtC2DDK2e6Hy1huv+NAIb1o7jf4MNm8tY
	xj6WguZEoLxPkS3dXbD9C/eILHG4MSLG+d1KKZH9uUeSqjTEs4hmLbeHANJGnKRaNXv1JTFhsY4
	6OfWEuEMbXJwNA/LgzsuR9QQ8yUQFrZ/hte67UbvDiN1snlDVFsAq2p0k6jv/k4uo/Tinn1fiJl
	JziXefsA8s3/PC8jDyClI77ZKlgIsU1F81meRjkCN13tIZONcpdXXTTRUaSHDaX21xcxSrVvFte
	Nh/yCKaBIoKayRY1xbHPl4h4g0PbTfsWuD
X-Google-Smtp-Source: AGHT+IHvjx1SEnBpdhEa+e/tHGVrysauD0Tv+bE0OKhtJaVJhTYhnMFVSCFuMzhnNWWQ8wz3N4wCwA==
X-Received: by 2002:a05:6214:1bcc:b0:78c:655b:b30f with SMTP id 6a1803df08f44-87b2105ac61mr317191456d6.30.1760380814262;
        Mon, 13 Oct 2025 11:40:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc346f6e8sm76509526d6.20.2025.10.13.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:40:13 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:40:12 -0400
Message-ID: <586cc14d04810b3154d2eda25d6b06a0@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251013_1430/pstg-lib:20251013_1119/pstg-pwork:20251013_1430
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: fix comment misindentation in audit.h
References: <20251008142719.2564034-1-rrobaina@redhat.com>
In-Reply-To: <20251008142719.2564034-1-rrobaina@redhat.com>

On Oct  8, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Minor comment misindentation adjustment.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev, thanks.

--
paul-moore.com

