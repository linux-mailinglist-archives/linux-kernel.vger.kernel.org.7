Return-Path: <linux-kernel+bounces-722333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD5AFD842
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA28B1C23CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82923D289;
	Tue,  8 Jul 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EN3+A39e"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E6188596
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006091; cv=none; b=BL4RK3ZHt/c4xoTqp6JKZ+qVwlrvn1Oxkv3hCtUJ3FbblMIDzdIk5ziiz7qY75uJfGFWupAp6szWHCNC4Pz1SCYQQVyBw7M5OmiSdDgvgSk9O/vw6YUHt36FfLDFVXl4Fh5J/VaOPWcAmy9T9rGFedy+eilZg80M9SLhXiYC9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006091; c=relaxed/simple;
	bh=rhVANd2CKHs5EuwB4/lOPiX5cc+fBw9k44oRUIqhsUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0NxhOLw4mxAsDFDMzlGRMmrDRtRwpMORIxehg3tm/NBKEt/xdMIzFXTt5sxoK7SdHL0tWq55ao1MIj/ku8rvOXO2r72BhJdAI3Ojw7Nh/cOSosIIe2VIEeGWcBB6aB2tsbxO5Dd9RSSYgvbgGNfcQjUfa/vFLmB0AnJb/N0hEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EN3+A39e; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso8600373a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752006087; x=1752610887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijYJWb4fuKBnre0sB5ESTtw7WT87hnOyRG+mP9wI11E=;
        b=EN3+A39eFX/KcKfTIQi8D2lr4WwmAjQcB54fYUZE66tHk2QM9hMiN/ccTiX3obtP4Y
         mc0AJFWH2r5Wu2E+dQJsRRZFQhzFCHRrBU5lcvlTtUPyX231zjx2U5RXlOjj2xniFnp2
         X7MYHzFeUZQfuouJIqKuMRdEjmIvRTQI8WR0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006087; x=1752610887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijYJWb4fuKBnre0sB5ESTtw7WT87hnOyRG+mP9wI11E=;
        b=KdaXWiCDTn1KfY0/Qk2aP4hYVafIJbabl3Lnkn5gIx4X0/ig0SigBRFexZLW+Wo2EW
         DBlwtw6GzuXCp3BZQth2C1MHzI1PO2GuJp6JoskeZPSjB82hEmIn79+37ph6k6EPfWtb
         SB6XPJdrS54lq1QFuEMNLwIWHDvjyDtX7DiSWYCQvplTcelBeaZkwHAG8nFMKE27qSvH
         lWG7MZyOz6nCfibh6fKYZSqGo3LjZGmCrs+o35Rj6ZjO+RRr14KZ2UzwYEM3j2Z6o1Lu
         jVKnX69tJ8sITqckyDfgEaUU0IOp9WOnV3/j0ap38FXaI/fOMjHA3EnhMI/OFXP4tFE3
         gbDg==
X-Forwarded-Encrypted: i=1; AJvYcCWaX0RI/Lccb1Pq7Ig6HBNkdzeWJfmTBFl/ny6nuEygFTiV6XI/ygxiIsopvaP4dRH5pRvYe5uiaKM0JGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnCeQmtiDwbWAQsrjkTyCMhIApNXpZ13DiJDq3cE/8eWeIC+RM
	nvxBNEsX7fNFFtsEYpQ3rWQABdWx3yxGPPqGGHT+OrlNe/EgAU/im7ajCWw08I2vi2dktxDvDGq
	jmqQGUOc09Q==
X-Gm-Gg: ASbGncueFua65XMk0gSelwxZWUvoZrFYufo8R5tRdk0vd5Ot2we2q6qW1ftMpMc9SO+
	T4zMkmjgpytY2InZkojl6C4jlkGfAvZoDGRA9GwLanqHU+EyV6/H5rkiIkmo3WeEDuiMr8ZqefR
	Y6to6YQM0VbVe1nysprgQP3FMpoh5RDapLlHJ2RwjyMp6SdLdAWWdgv3FBGm6TD/eYAEF8nRdtB
	33qWWpcE4Crkyru0ZxPmhsNx6mIykotHIgs0K5bOf7pGHUuieCkYBr9hxCWitEgRW2h2XbFMaAn
	ZGArU4cQMZUw8S9COqJzMr5dC1Xl+aCsTAiZ/TVO9Pm/T9MexDdzHFbTC89C2klEVYKE06ECace
	xnP3pzwae0uQ8IPCAp48vCk52LuliKPj8+uAyHuX6znj7+ok=
X-Google-Smtp-Source: AGHT+IHzLJN8iNPgnVEUqReYmyBmrSMVsPpAmcNOb9Om0Luiuon4eaScdc9xopM9qA+zQct6TYtZag==
X-Received: by 2002:a17:907:94cd:b0:ae0:9fdf:25e8 with SMTP id a640c23a62f3a-ae3fe7406e8mr1779630866b.47.1752006087460;
        Tue, 08 Jul 2025 13:21:27 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b0335fsm944092766b.129.2025.07.08.13.21.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 13:21:26 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so8996254a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbI3X3D7HWjkFIIy6aOfTccU38IkKisshwA0vF1aE4/awkAGIFCUHXjbu17m3tZyCIFdYsvWgYqX8eOGw=@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:609:aa85:8d78 with SMTP id
 4fb4d7f45d1cf-60fd652543cmr14984957a12.8.1752006086225; Tue, 08 Jul 2025
 13:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708193822.45168-1-da.gomez@kernel.org>
In-Reply-To: <20250708193822.45168-1-da.gomez@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 13:21:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
X-Gm-Features: Ac12FXxAhDZRAkaLA0YsEY4-BABaOKocyzik-IBHOi0g_zOdXugIsdaXaIH8dCI
Message-ID: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.16-rc6
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 12:38, Daniel Gomez <da.gomez@kernel.org> wrote:
>
> Petr and Sebastian went down to the archive history  (before Git) and
> found the commit that broke it b3b91325f3c7 ("Don't relocate
> non-allocated regions in modules.").

When mentioning git commits in other trees, you really do need to
mention *which* other tree it is.

In this case, it seems to be

    https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/

that has that commit, but that's actually a kind of odd tree.

The typical bitkeeper conversion tree (which is where I suspect the
full-history conversion then got it from, unless somebody did a
separate conversion) that contains that commit is actually

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

and there the commit has commit ID 1a6100caae ("Don't relocate
non-allocated regions in modules")

                 Linus

