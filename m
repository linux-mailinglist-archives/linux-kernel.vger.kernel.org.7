Return-Path: <linux-kernel+bounces-752547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA88B17700
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E7B1C21ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348925F97A;
	Thu, 31 Jul 2025 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3wC9+PW"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BA2580CA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992948; cv=none; b=tG16FT8Z57hbDTboqmMrXiifSfS1JV96PseTGtvNy8/x8debNfA3gWKvcVbt859ng8rQ3zjfiBcVqGvqBSTnVP3PUgFd20Dcxi7MBzgtNV2nfV15geoU+esU0UdGHFbG2v2DJokSfinXZQ+yDXBvtlQyz5l/2Z+GzRpGhAG0mwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992948; c=relaxed/simple;
	bh=Ia1ZZKWtJtR5buYogOO6Q7PVJmaMC4fPTDBMwxHYC48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9jL/vawQCxwyTffCk5LNSjNXBSLXrLszgprdBUAnZIMg0bItJRQGfPPcQX5yJfkmhJUEJ0jV8KyXvJcjFcZNs0HxI/2Afaw/9YcdzSMYcO1Vbrqr7kjzTR7RMxVtj9mtIdYxftyxUwXpJFjTcRKvqErgS6e1li+7F52XqOdUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c3wC9+PW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso170395b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753992945; x=1754597745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ4qQ5QAOwj2KG3QXsyre1rk2lllpKmvahjj4sEjzfI=;
        b=c3wC9+PWDaujCV+3YuNwd6TBuQXjTK3XYatNDLCpifmYB4yVAEpq4NUUpqjP/Wn+kX
         lKGGL3wjYBvktsq+tXSl68jdISIY3xYH1DnBDgGt2ucb0be/e5pp5jDr2wP4pi/kiW70
         qil+IJBDoFm37kZNXSib0s0c4g8eaR0RxrRjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992945; x=1754597745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ4qQ5QAOwj2KG3QXsyre1rk2lllpKmvahjj4sEjzfI=;
        b=uX2BLXAsCOw3HynkDYL0HANVWSw7S/87ARr7atakkODvU+1D5uiB8s/PAq/wnxkVKg
         yukaPlEdwDMs2hqNI8vO68BDChjuDBt/m34d+lNAGD9Kw0RlHOiFQ8NXRafVKHhnkLtV
         SkG99uleNW2dUK8i5miO0njreok1eQIlgylXxP+Jq9F+el9dP+g1AiDv0x/zZhhTTXRQ
         qgd9OmLdobhRbz8QPgBTYoe5EhJa471qMi9U9RmeEXF1bT+2jjelZA1mmqdADfQ4y1gD
         Ao+cEBVAgFcx0pFepLwsYDFH5c9NTjbVHXXvZG5fCl/omnA0GqaJ73/wmH8MWFrqEy03
         rymg==
X-Forwarded-Encrypted: i=1; AJvYcCVf8Gwkjk0PCEbHRUyV8iqaOX+w53CEK3dCWYp1bfACoSfBdeBNS9JNaXxMu3yyB3nApKTnSZeBlTNy6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m9PMlxnzjTzcA2oondSfc2kJfz86wf6Er5WLynTrXAqCNrXn
	cU1u3irFvzoUut4xexroZKskThIpTAhFbwsrdVf10O0B1oG5W5YQID/nYsoKmE0tsal0RRKP/pS
	57pE=
X-Gm-Gg: ASbGnctfdjd8vHuI+QTnIPoBY7oyHo5OTqnI0ffRmV707MMyd4229AaFmpa8As8RWlj
	T9+O8iruuKb0vbtmsLPOIVodHXbS+67lish/e2xQz0l72b8D0AXr316w48l7UyEn8QHZvXkIoMf
	X8si/AhgVBTpQ5iqcGV8vcMgFuLQ4w05tzfgG6dYSQ3BzhtPjPfhNp5kO53DeW6xSTFLhnx4DVc
	WDmGpK5S2FHPR6NTbcfr4HyaxW174KgY7RdB5SXxYYAWipUGo62OP9Y4cDBAGy+d+ycjUVrH7Fp
	gsGtOS9Oez40eWBqtU5lp8nnqex1XPTT2pcb+5hWS6YylZd6MFAzdw1crMifZ8Ic2Y65T+tol/q
	AWkSxOnzHTUo9IgpuA+7XXErMv/JH8/Y9pJ9tvKMp3YcErcizu/o+9I5qPxmoxy4cOJwh0RNZb1
	Pm
X-Google-Smtp-Source: AGHT+IHzOSnHunqLvSiaNr9DxPqpXls3LG//03w2dGQ6DH8B+BBKCReRGPtZZFT14TuBuDUCmE4Isg==
X-Received: by 2002:a05:6a20:5483:b0:232:1d30:cd6e with SMTP id adf61e73a8af0-23dc0eba2c0mr13753835637.41.1753992944235;
        Thu, 31 Jul 2025 13:15:44 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bae2fe7sm2186251a12.44.2025.07.31.13.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 13:15:43 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4239091fc0so107297a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:15:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7qSJ3tU+sPDP+1E11rjVqHggJVVoYS0nYYEziFxzVq6GtWdvHysV2e6sFKGEknDnHwODwY65vhUzxeQU=@vger.kernel.org
X-Received: by 2002:a17:90b:438e:b0:31e:cb1a:3dc5 with SMTP id
 98e67ed59e1d1-31f5dde7723mr10425027a91.11.1753992942301; Thu, 31 Jul 2025
 13:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731105939.2692654-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20250731105939.2692654-1-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Jul 2025 13:15:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XhB5+DVo3zskgriTY37V9vfCSnVz65n7smCFPSZEm3hQ@mail.gmail.com>
X-Gm-Features: Ac12FXwfaTf4jQ_Q6c15BHLawgglenxeYKnVJOowrbwJrI9lAxfiRjWiwoeB3aY
Message-ID: <CAD=FV=XhB5+DVo3zskgriTY37V9vfCSnVz65n7smCFPSZEm3hQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm/panel-edp: Add edp panels used by mt8189 Chromebooks
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, treapking@chromium.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 3:59=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Add a few generic edp panels used by mt8189 chromebooks, most of
> them use the same general enable timing 50ms. For BOE-NV116WHM-N4B and
> BOE-NV116WHM-T01 CMN-N140JCA-ELP the enable timing required 80ms. For
> CMN-N116BCA-EAK, the enable timing required 200ms and disable timing
> required 50ms. For CMN-N116BCL-EAK and CMN-N122JCA-ENK the enable timing
> required 80ms and disable timing required 50ms. For TMA-TL140VDMS03-01,
> the enable timing required 50ms and the disable timing required 100ms.
>
> AUO B122UAN01.0:
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 06 af a4 04 00 00 00 00
> 31 20 01 04 a5 1a 10 78 03 54 c5 9d 54 55 8f 25
> 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 fa 3c 80 b8 70 b0 24 40 10 10
> 3e 00 06 a4 10 00 00 18 00 00 00 fd 00 28 3c 4b
> 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 42 31 32 32 55 41 4e 30 31 2e 30 20 0a 01 7c
>
> AUO B116XAK02.0:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 06 af b0 52 00 00 00 00
> 2e 21 01 04 95 1a 0e 78 03 5b 35 9f 59 55 8e 26
> 25 50 54 00 00 00 01 01 01 01
> 01 01 01 01 01 01
> 01 01 01 01 01 01 5d 1c 56 a0 50 00 19 30 30 20
> 46 00 00 90 10 00 00 18 00 00 00 fd 00 28 3c 30
> 30 07 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 42 31 31 36 58 41 4b 30 32 2e 30 20 0a 00 bd
>
> AUO B140UAN08.5:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 06 af ba 8b 00 00 00 00
> 10 23 01 04 a5 1e 13 78 03 7c f2 90 57 59 93 29
> 1d 51 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 26 3d 80 b8 70 b0 28 40 10 10
> 3e 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4b
> 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fc
> 00 42 31 34 30 55 41 4e 30 38 2e 35 20 0a 01 29
>
> 70 20 79 02 00 22 00 14 7b 63 02 85 7f 07 b7 00
> 0f 80 0f 00 af 04 27 00 02 00 0d 00 25 01 09 7b
> 63 02 7b 63 02 28 3c 80 2b 00 0c 27 00 28 3b 00
> 00 27 00 28 3b 00 00 81 00 15 74 1a 00 00 03 01
> 28 3c 00 00 60 51 60 51 3c 00 00 00 00 8d 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 31 90
>
> AUO B140UAX01.2:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 06 af ba cd 00 00 00 00
> 32 23 01 04 a5 1e 13 78 02 ca 31 9b 5c 58 8d 26
> 21 4f 52 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 60 3f 80 a0 70 b0 64 40 30 20
> 96 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4e
> 4e 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fc
> 00 42 31 34 30 55 41 58 30 31 2e 32 20 0a 00 46
>
> BOE NV116WHM-N4B:
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 09 e5 45 0d 00 00 00 00
> 1f 22 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 30
> 30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 56 31 31 36 57 48 4d 2d 4e 34 42 0a 01 c1
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 4b 51 4b 51 3c 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 90
>
> BOE NV116WHM-T01:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 09 e5 df 0d 00 00 00 00
> 01 1c 01 04 95 1a 0e 78 0a 81 15 96 59 5a 9a 29
> 1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 6b 1b 56 64 50 00 1e 30 26 18
> 44 00 00 90 10 00 00 1a ef 15 56 64 50 00 1e 30
> 26 18 44 00 00 90 10 00 00 00 00 00 00 fe 00 42
> 4f 45 20 48 46 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 56 31 31 36 57 48 32 2d 4d 30 30 0a 00 83
>
> CMN N116BCL-EAK:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 0d ae 5f 11 00 00 00 00
> 08 22 01 04 95 1a 0e 78 03 46 a5 9c 5b 53 8b 24
> 1d 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 e6 1e 56 e2 50 00 3c 30 30 20
> a6 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 32
> 32 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 4e 31 31 36 42 43 4c 2d 45 41 4b 0a 20 01 9b
>
> 70 20 79 02 00 25 01 09 fc 34 01 fc 34 01 28 3c
> 80 81 00 10 72 1a 00 00 03 01 28 3c 00 00 00 00
> 00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2f 90
>
> CMN N122JCA-ENK:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 0d ae 4c 12 00 00 00 00
> 11 20 01 04 a5 1a 10 78 03 0a f5 9e 5c 52 8b 24
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
> a6 00 06 a4 10 00 00 18 00 00 00 fd 00 28 3c 4a
> 4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 4e 31 32 32 4a 43 41 2d 45 4e 4b 0a 20 00 fd
>
> CMN N140JCA-ELP:
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 0d ae a8 14 00 00 00 00
> 1d 23 01 04 a5 1e 13 78 03 28 65 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
> a6 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4a
> 4a 10 01 0a 20 20 20 20 20 20 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
> 00 4e 31 34 30 4a 43 41 2d 45 4c 50 0a 20 01 c2
>
> 70 20 79 02 00 25 01 09 94 5a 02 94 5a 02 28 3c
> 80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 00 00
> 00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 90
>
> CMN N116BCA-EAK:
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 0d ae 02 74 00 00 00 00
> 2a 22 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 04 8c 10 00 00 1a 00 00 00 fd 00 28 3c 30
> 30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 4e 31 31 36 42 43 41 2d 45 41 4b 0a 20 00 ba
>
> CSW MNE007QS5-2:
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 0e 77 62 14 00 00 00 00
> 10 23 01 04 a5 1e 13 78 03 1c 2e 93 5f 58 95 28
> 1f 4f 58 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ea 3d 80 c8 70 b0 2e 40 30 20
> 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4b
> 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 53 4f 54 20 54 39 0a 20 20 20 20 20 00 00 00 fc
> 00 4d 4e 45 30 30 37 51 53 35 2d 32 0a 20 01 8e
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 00 00 00 00 3c 00 00 00 00 80 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1d 90
>
> CSW MNE007QB2-2:
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 0e 77 68 14 00 00 00 00
> 00 23 01 04 a5 1e 13 78 03 90 e0 90 5e 59 86 25
> 14 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
> 36 00 2d bc 10 00 00 18 00 00 00 fd 00 28 3c 4a
> 4a 10 01 0a 20 20 20 20 20 20 00 00 00 fc 00 4d
> 4e 46 33 30 37 51 42 32 2d 32 0a 20 00 00 00 fe
> 00 43 53 4f 54 20 54 33 0a 20 20 20 20 20 00 9a
>
> TMA TM140VDXP01-04:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 51 a1 11 08 00 00 00 00
> 1a 22 01 04 a5 1e 13 78 03 83 3d 98 5b 57 8d 28
> 1f 4e 53 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 6d 3d 80 a0 70 b0 3c 40 30 20
> 36 00 2d bc 10 00 00 1a 00 00 00 10 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 fd 00 28
> 3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fc
> 00 54 4d 31 34 30 56 44 58 50 30 31 0a 20 01 f7
>
> 70 20 79 02 00 25 00 09 41 66 02 41 66 02 28 3c
> 80 81 00 14 73 1a 00 00 03 01 28 3c 00 00 00 00
> 00 00 3c 00 00 00 00 8d 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ae 90
>
> TMA TL140VDMS03-01:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 51 a1 94 20 00 00 00 00
> 0b 23 01 04 a5 1e 13 78 03 47 5a 9e 53 5e 8b 28
> 23 54 53 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 03 3e 80 a0 70 b0 48 40 30 20
> 66 0c 2e bd 10 00 00 1e 00 00 00 fd 00 28 3c 4d
> 4d 10 01 0a 20 20 20 20 20 20 00 00 00 10 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
> 00 54 4c 31 34 30 56 44 4d 53 30 33 0a 20 01 9c
>
> 70 20 79 02 00 20 00 0c 00 00 00 94 20 00 00 00
> 00 0b 19 00 21 00 1d c8 0b 5d 07 80 07 b0 04 00
> 48 c9 55 48 a5 90 7b 42 21 02 45 54 00 00 00 00
> 00 00 12 78 26 00 09 02 00 00 00 00 00 01 00 00
> 2b 00 06 04 00 28 3b 00 00 81 00 14 73 1a 00 00
> 03 01 28 3c 00 00 00 00 00 00 3c 00 00 00 00 8d
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ae 90
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> Chage since V1:
>
> - Add edid in commit message.
> - Modiy enable and disable timing for SPEC.
>
> V1: https://lore.kernel.org/all/CAHwB_NJ3yQxf9fTMT_cQv50z8X_NKyQMOJEuqDqY=
-BfKX8QzXQ@mail.gmail.com
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add edp panels used by mt8189 Chromebooks
      commit: 518867b09394217d13f6e05f704450bd9d2c8eeb

