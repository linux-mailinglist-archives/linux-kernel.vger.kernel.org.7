Return-Path: <linux-kernel+bounces-829224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6740FB968F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6AE7A75A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C42561AB;
	Tue, 23 Sep 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X7bQANTw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C64243371
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641129; cv=none; b=lBRxTrIAb36C/jIJRHHoGkYxtuo4brY0p6sBMQ/h3tW1fqOWUJvLAdXZe3j+jJY5YQmR/vUhQeYIZboxyfwSKmiktN9hjlp3xW0fGUaHE9XGogbrT1niGLIBMvS0AEnO8wjWOWhJcg8D/zxs95EuUwuFiJNXArISBzNPySJW4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641129; c=relaxed/simple;
	bh=JAs8cmBMqm3kFdExAU2wLuKhp0hhzgMnaX1Q1vHYD2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUpqxg4RbOnVtPglQocvu/ErN/SMbncw5Gk2WMfBkzvaYvYUfj674j32nZ+1edQ0h+PXy0l4OeGV0N8sI0FltUdF1S2ySI0kDzoz1v8lfy6z4g38em8oO1TvETA/S+JXPhDGCoBmBwuRxvHpi0cCSAKRCWQEljPf8FYQvNFq10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X7bQANTw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63053019880so6214585a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758641125; x=1759245925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NHqkMf0CIdPVb3vixYXIX4KbVCIYAv5dXkbwV5m89bY=;
        b=X7bQANTweQtX3WALFHCj1TqDFvuYdtb8es9fXAqRgM8H4HxpMS0BSbToTEE0MOdLrk
         W9+fIHKxhFmQqYZZ0zEMazbql8BFsILkTVsyJDo3w8IeVIuEAX31s7OW5KtrJ05DjgTi
         fXOcNjfn1iU4yYYDT4WXfHfiZI9mySdK37oSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641125; x=1759245925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHqkMf0CIdPVb3vixYXIX4KbVCIYAv5dXkbwV5m89bY=;
        b=C17OIaLh35NfswzlHpOBJaFUi2T5CzAPGGyOFqL5Vvu97umi6rzREe1TJrhYvYUN/j
         SzSG5uQsCVuiQZmlw0vy9nF1/P8rEtttMoXq4gIP48KSSc3XLlrXi912C7Vj+UOVCHuh
         7CeO+Uwje1QbEOd+94F0w269rE449dqVW/27bhkbUm3LbvP5mFSmor+Bs4xyo6u3dAEk
         IYuBL7R0hs0t7KRr5agbutgpZ7qkJN0eKDUknXFXYVYg+tKJS+K/PpQopJ1MQnJhTyDt
         aS9CGK7S2e4+m96qdOU/dbwGF6g5sgEcXsOIhWATz604Ea95BFSZ+NANsAyvY0eHXB+q
         XA8g==
X-Gm-Message-State: AOJu0Yx6TC2BiXEW44M4ATCfecspmeXILq+Vm5Al6j/Y9d2OHcICio5p
	ZFI4uJ+9gIxp9Rjo4/lYKGYmv+qJKSN/6i7oT+8jh2NyZcLG76g33u7FtYp+1OvrQTuAB4/PejA
	/Lrjx4RI=
X-Gm-Gg: ASbGncvfx0EUGEx9zYHYWVOEbiBGhQQsE8D3h+rZVER7EEIoIBbGVV3EyimSKPK2hd/
	jGeXL8msbMRIE+6c9dH7Hw/E3qVWo63k7AX5o43sLnrDreB1dlzfKuOB/c/vic3z/IK5e8OiJeP
	7wZrqHFKTqjrQ1Sl0mtzkfXfHfaVUj6ImNi4TRD1vEUMdWxE3UnGjlD9asAlFfF+NBmC+FKe0Ig
	iNI5/kJri1hvNK1lu1ODUMwYQefgr/+UKAFNWUNWhNI34pnia/5E8GbPYRFp4cMSJLs5O3bnnB3
	QYvSFPNlYEHX35zwK/sEw2Bg8paUUcr3BYsXL+Xf1SVvWxvDJ7kjri8Vlmvxv8bJ+xBvghjgxu9
	nVwkFubSCoO7kVrIslY9exlBxFgyNF6c02aqeZUv3+dQuOw3ElJ188OLpxNFt7CtbptqGR8HB
X-Google-Smtp-Source: AGHT+IGoqKZc6dVlLktTIaBPiF7O9X0hHe2eWv/RSDqZ+owb4W+JdKSIFNznerUH9YhOGq92uhQqMw==
X-Received: by 2002:a05:6402:3488:b0:62f:77fe:bbae with SMTP id 4fb4d7f45d1cf-634677eaacamr2586450a12.24.1758641125440;
        Tue, 23 Sep 2025 08:25:25 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f4173csm11199434a12.49.2025.09.23.08.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:25:24 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07d4d24d09so968912566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:25:24 -0700 (PDT)
X-Received: by 2002:a17:907:9287:b0:b07:c815:70a9 with SMTP id
 a640c23a62f3a-b3028427f9fmr264168966b.26.1758641123996; Tue, 23 Sep 2025
 08:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNF-Mqjnu_phEgvP@slm.duckdns.org> <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
 <aNK5ee-9NScZ-l_r@slm.duckdns.org>
In-Reply-To: <aNK5ee-9NScZ-l_r@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Sep 2025 08:25:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjizJtEJtbLJaY5RftBKtM8Cmk8Um1XAeDX2+4dyD6O5w@mail.gmail.com>
X-Gm-Features: AS18NWCoeHg-XTAPe01xE6AHSntJZbmmZSwyabFa5VorL8XVFHeO-_R8V8HVH3I
Message-ID: <CAHk-=wjizJtEJtbLJaY5RftBKtM8Cmk8Um1XAeDX2+4dyD6O5w@mail.gmail.com>
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc7
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 08:15, Tejun Heo <tj@kernel.org> wrote:
>
> No worries. As long as you don't swap e and o in the last name, it's all
> good.

It's a perfectly good garden implement, I'll have you know.

But I'm sorry that I have now caused you to have to stand in line at
the DMV for hours just to get your new name changed on your driver's
license.

Annoying, I know, but it has to be done.

            Linus

