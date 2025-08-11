Return-Path: <linux-kernel+bounces-763433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC542B2147F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7721A22CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408002E2833;
	Mon, 11 Aug 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFEhAf1/"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA42405E1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937422; cv=none; b=XzBiZ5tw3/SEEih3725WD3U/gsnloiuKpjW3Au+tzY+W49RRcnuDdL27UVRrE4/cWzwsOFVAY0j+aE/wAGtRLl+BU78tkujwxZozGpGi8OTKILipK+xDI2WWlSxEjFXT1TAS14IG7llaBZCRIXUu6xgzoh/JC+52IhP0ybr0Wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937422; c=relaxed/simple;
	bh=tzOPtsgEwMKkFkcvcONBP6f+sHuMgKh5w93R9jVoA6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=Mz/u6V7v4j4BN6tdGldyKuJUNG7DkdTNMm67SXoES0Mx0qF+UDW+9qzr4QemXjqeDa+2nuYQIeHfdNONWN99wnwoCx49lt7dZpUQ4LRsBMyMvXmxubOiu4haCWMI1En5ZxSeMnrU6zKY0fltGyMcaCLVQF/LRtrFQ5E5wp1EnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFEhAf1/; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af96fba3b37so880633066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754937419; x=1755542219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ju+Vut5YUUeAR9QwRyn7TvMmpF/0hJ6XYyRbURXSpA=;
        b=RFEhAf1/hV5S7CVhWutEooqUvAflYxDmWH5Oxd+ZeX347YHAlu9bLqhJDl4v8gX55F
         akCtS88iurKzFNqlZnkzNzYs1TlfjMSrMLIJEwofOLpQEOujGymeY2XS2ktz6sUDxnOv
         ujHJZFaFOaq02QRpqSHGJXrR6aTLtR68sfB+WVnDPAHzJvUENF5lgiEtSDVg6Qck7r0C
         u3WhWbpgl4WZyIU3IW9MZW7yXbgfBKAhu58gT24vr3oEWiFR+C0uksanEbb9D27I72WV
         XkqxyrQXYczN6A3m6Y9K5EVysuGsx9LQ/1EXHf6rx7EFUSa9lFX98iZ+88skeAsdHcgr
         CzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937419; x=1755542219;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ju+Vut5YUUeAR9QwRyn7TvMmpF/0hJ6XYyRbURXSpA=;
        b=uaAAgD02gZPuLxuCyXP4caeD02JzNFgGcbEA57pwKVEVDn3CuJo24vOqEVgYUNr5Ey
         jBt005MCuhZrmP2eeSRvPbfnEE5S7DCKQvvP128sfw/oIVcAbpJLbeqELT27ydackt6x
         SZpApogdr+6lp8u6XS7wq+SCw+AaMM+1cV87hWj5qbhWqxqoYuOES6ViP8SCTHmdowfu
         CnUB0zQOlc4ZvjCoO8Z6JQBmr4OPvZ3RyeS/ydxBXUoX4Rxdb1j+aTFgVYRijItl5xLJ
         NlA9osspjqDdXssNWGCFZLIdvPJa6YRoQZpSYnGwmCxOVE+u7CUoB+g+BAYcOy4ugTMw
         63Wg==
X-Gm-Message-State: AOJu0Ywib7n629BKDcHJrR+TXz9paG3US+8e7i54yKzFN0vahs9BTTAK
	zZtRMARcfCNZCVnYe13gG/vJCFDzyVGTifwnFJrPv/mnRtQWXjtXJd6oYPGEiLo0nmsCTJNew7T
	2sNNnkih1w+zuqU/TyhVHYZedb97BVDd5k21UQ5YKm14I
X-Gm-Gg: ASbGncuroHgR/381XE5VF84cHopwLk+YHb/tpTd71T8n234aAqBGpkVlGZSDV7p5Ln0
	8uVcBnEoACdRDfHfMgfluZejh07HTSZlAWrUEKWQphKWOcXMq/6LVdHtBVgcf5QX3ECtgzTTNJ5
	u5a52dLGFnyDW15gyXZx6WajQJ9hGvfcCB+OeDh8lIkT082zoW0yE7v6RiCByS+KnfP83L0sps+
	SuRCOkX8E2D6/2iOIHmjtYzHpyYBqgyFv8tqHk=
X-Google-Smtp-Source: AGHT+IHM/vnpyOXB02+dgtFYnJ0IGRFphLbHcwfpck2Mrlf+oOMakAlNv+/iKGX5h8uuPMVruDvTv3J0OyebqqvxljU=
X-Received: by 2002:a17:906:4795:b0:af9:c400:d6ee with SMTP id
 a640c23a62f3a-afa1e1f4dd8mr37856166b.61.1754937418905; Mon, 11 Aug 2025
 11:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181839.40336-1-wjl.linux@gmail.com>
In-Reply-To: <20250811181839.40336-1-wjl.linux@gmail.com>
From: Jialin Wang <wjl.linux@gmail.com>
Date: Tue, 12 Aug 2025 02:36:32 +0800
X-Gm-Features: Ac12FXyV28tEbHtklOHYrZF7zI_VYCMOkmvn94rn86Q1kNj-cqilOqSv6f5_m6Y
Message-ID: <CAG18JnyyyReXCKRhoF86DhAWDa1-jhdHULdFKULdRRLSs7QKKA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: remove redundant folio_test_swapbacked()
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 2:18=E2=80=AFAM Jialin Wang <wjl.linux@gmail.com> w=
rote:
>
> When !folio_is_file_lru(folio) is false, it implies that
> !folio_test_swapbacked(folio) must be true. Therefore, the additional
> check for !folio_test_swapbacked(folio) is redundant and can be safely
> removed.
>
> This cleanup simplifies the code without changing any functionality.
>
> Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
> ---
>  mm/vmscan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7de11524a936..9d4745ad5e23 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -985,8 +985,7 @@ static void folio_check_dirty_writeback(struct folio =
*folio,
>          * They could be mistakenly treated as file lru. So further anon
>          * test is needed.
>          */
> -       if (!folio_is_file_lru(folio) ||
> -           (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
> +       if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
>                 *dirty =3D false;
>                 *writeback =3D false;
>                 return;
> --
> 2.50.0
>

My apologies for sending this patch to the wrong mailing list and
missing proper cc's. Please disregard this patch as I've now
resent it correctly.

  https://lore.kernel.org/linux-mm/20250811182500.42670-1-wjl.linux@gmail.c=
om/

Thank you for your understanding, and sorry for the noise.

Best regards,
Jialin Wang

