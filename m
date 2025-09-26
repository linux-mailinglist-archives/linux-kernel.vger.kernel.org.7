Return-Path: <linux-kernel+bounces-834256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0EBA4465
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEF7560026
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8A419E992;
	Fri, 26 Sep 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gmqef7SV"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA717C91
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897869; cv=none; b=KB8/dMNbHk4LfVV2TUMOJ8FUDy5yCsLr3SnuWgLYTy+EYB7Fk/OBKohQONd8qB8y7cMV06CfS7TrVuHGeFg/zphX5k1ZfHYHk0ug0fGKyz0Vv991hGfLKH4Ljlq3+7HtxtWLWlQds9eL7oQFEkWKLU+bU9dUT2Kur6+xjmgULXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897869; c=relaxed/simple;
	bh=qMppqb+CsDKsBDctWvW8PXL5K1HhNDMIfSUBQP+oGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6jXbhQ5h1UIKU78Zugapd7hMoMhGaySuFbe3AYAzxWr/Y+LD/ko3eFunJzLHO3X0CtPnLqNqNci1KMmYH6VZedfsWYkSASEiNN6FJBNqGMtPzGfwImhs9sjSV+3yt0D6BYGYFME/uN0J+JA01WhlGgKEMtcugGvEw3JT630dX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gmqef7SV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3727611d76so245187866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758897865; x=1759502665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuOcMyyuB1YVHMoA1Pld51FVGBjUFoZF1fWRkZlzCjo=;
        b=gmqef7SVSWoDIHPoQmk7vbUUqXUtAPPX99orLI3ypnqUnzx92UkQ52TpDY4/nBnghH
         Hdh17IEyU23RaSz+XUS/46corUPpkIUy26UW3qxl0qDlqn3Kj9sD20SX973+LgLrXGRP
         wIdmxhCjeEebab1uYg/1RLHzNVb/8yT7+nJkRCpk3P/Shkp1aqL26t0OIZ29b8SbO1d4
         zWyS2Qe3w9IxNaOJ7GNX7XRSHG535Bcvo4E8QdcHv1p1dYAISsaZlkHcZX86rtyIc38I
         Xnjgau+v4BmryVS7E76zhlmSaoeW3iERyGPOhJ/1oJ1OHOx35U3ksacJa0eKtwgK9bUo
         Hktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897865; x=1759502665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuOcMyyuB1YVHMoA1Pld51FVGBjUFoZF1fWRkZlzCjo=;
        b=nRdaBKZnmV0zff1WmBRF+o1xLMQ3wuuQmrRIsq82nCULEno2eSR8VLe+LRMp4vG4vE
         gbyFZfo7JkYQzESbzVLboPy9qV6erVbRxlc9cxWyPZ68u5fp5mz1Viz/vjmvvIDuxU7B
         oJC3Ycj5fOL91uajU7FSNdmJVY9xCRvIHvy/2HYySxN1oWz+IY+GV1aIPc1+dINgdQP3
         9kynXDLwVqB8OpjVpwqqhZ9SRnoQ/chBi3USrxzKsO9oEWhyufBURMNlttf0zFf0JXYF
         d8BAjLaGhvm3UsIgrLHA/6kF3nrQRt+aUXHTXBnXIU0fon1Do+GXwvIkdnTKbRYutm97
         nV4w==
X-Gm-Message-State: AOJu0YzVYI+UihL5EGczXdqQ0U0D8z0GgbyI62/P3TDheCQzRMZsu0HT
	nEv5vSk9ZhdVDirHpMRC7MYs6vqqmgJaE/AIfip24/cupzOg4q5ooqdbUkUzg04X7Fs=
X-Gm-Gg: ASbGncv4CKvZUAYYPwjQbDYrObpCarJduqFjQqIE5G8BllyyL5rwQG14tjifvCMOp3i
	olp4q0as8NRLnlaD+mYkh4Iq0rawH+0szSfsig9hmnXbC4cCbpxwvDIIeo1hO8AiQFof6qzwvkq
	MhQtuzQExfb0pb7iWM8kjVebU5lz7rOy3H2WV9wGFIl2ECi+Eo+3xYmnf+0b0g7mfx0e1lDrWYK
	qSUNgMHVpUT6vn4RKJd8qNH+TPUiHE6cH0qQxtNCgEIghEsU20PDIUfCXyA/ojtDUcOlq47SGM3
	zl6ZPy0rMhIHAFjwDoAMEvk+ykXTA4s3lzN2ERqpiwO3kLzwX5IhwTb4FVvBwnMdOTEOYjqMQyI
	Y92op9zjDPmeVjOI4jvwxNkA1zzx7XAIhIkpDuHL4
X-Google-Smtp-Source: AGHT+IEa2rxDSKMejzy6q7qh6tArTajnPkzC3ce9vluXpalPtT6wop2/OTbvJ/E1zQ2B/y4Z9Ipa4g==
X-Received: by 2002:a17:907:3d90:b0:b10:3eb2:2074 with SMTP id a640c23a62f3a-b34baa34934mr962612966b.18.1758897865321;
        Fri, 26 Sep 2025 07:44:25 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65880sm377693066b.45.2025.09.26.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:44:24 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:44:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aNamx2ZZEJzSCCfu@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905144152.9137-2-d-tatianin@yandex-team.ru>

On Fri 2025-09-05 17:41:51, Daniil Tatianin wrote:
> Previously, data blocks that perfectly fit the data ring buffer would
> get wrapped around to the beginning for no reason since the calculated
> offset of the next data block would belong to the next wrap. Since this
> offset is not actually part of the data block, but rather the offset of
> where the next data block is going to start, there is no reason to
> include it when deciding whether the current block fits the buffer.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

The patch looks good, especially after understanding the problem
with the maximal record size.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I am sorry that I did not wrote this earlier. I am quite confident
with the patch but it is quite tricky. And I do not feel comfortable
with pushing this for 6.18 (the merge window will likely
start in 3 days).

I am going to queue it for 6.19 so that it could get enough
testing in linux-next.

Best Regards,
Petr

PS: There is no need to resend the patch. I could fix the indentation
    when committing it.

