Return-Path: <linux-kernel+bounces-846000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE922BC6B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D64E9BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5C2C0F75;
	Wed,  8 Oct 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tevq4UlC"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BE29B77E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958973; cv=none; b=Sg29HBrjVmW3WyIOJesYpnGWSc8WGh5Vur+rtWhApIgihVH+ZivGNq3v0xLnrQ5xHOTUy6uzLQAEb8rvx/e5UjouhHpUi+T/JZrKzTHiZI2oEirK9GzOFy5NoDym5MLt/8n9yLEz+oPbP4t3Rzd9RpGB/j1+X7N2AHQgleD0Fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958973; c=relaxed/simple;
	bh=2yzUnr9Ui0L1rSmCiCoKOl+dint/zZhYkZEu4jNtf1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+D6VIcnAD6UMTRD+ltvYmJq6ORqAHK5jjuFmpUCEkrhZUooGQUH2CNKbciOIgnKoDpiIBj1l5WKlCvFZ345I8tz3uOZqXzHPjN19aMhKiMcdrd7qxVXbbyjcjICu7j4bfApaJsldTYvcwA7IjkU0BNwc6/GTm6792AwO2Ej4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tevq4UlC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7b97ce4fc60so107976a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759958971; x=1760563771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yzUnr9Ui0L1rSmCiCoKOl+dint/zZhYkZEu4jNtf1U=;
        b=Tevq4UlC4X+tyvS91mM/Os1W33dJeCi4j2vIX77VjZYOGA+9KrkD9mPSi8B+/WUSZP
         1ClNvfuDRMnsPEOMp2r6zVreHp13o/90CjJzvYao6pB4wGTwcgTsA13FzrvJLlcJ0bDG
         iDwr+S606AhcT9QA4OpCXWNo8kpqB0AUGlmFObg2Q8N+XoIxdqXu2okKphOlku9bpRU2
         lnd2DZ6Y/1uWAmTMJ3Q7cMO2YtHYdwlx0ac2EBwJQ8BiZng668PDzEHw9kxPd5Ak9Z1W
         YfC0l0O4o8e/+mux3qoiwM5MAK05vj2AHEYMZ2Rue+K/0Htx8jz74zWC0OTSbpVnTMAe
         TKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958971; x=1760563771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yzUnr9Ui0L1rSmCiCoKOl+dint/zZhYkZEu4jNtf1U=;
        b=G567pCvlYPLORIZTcp85A5sF9qlalRemSXMRip85VdSaaDs3LUf2rpwWtIGVs9rNzD
         Bdz3PWkgWcHz/sVoi48nkjht+ACrlSeRjnbUjazEd21IvzmsO0vzGyK2uPrEOgO1vJ2F
         aWwLB42uWZhlphR8zKTJpco9ayOjuB/3jUUhRJkrd13rzAMP+QhbyTQrIpB93rT+Zl+D
         vs/LObLlKGlKTTAFNx7DEgxH8auxyF5Q85T95tUtXK6pJumJWjSCtqHzjnjaxkttKlE+
         UKqadKJBHWyIn1K9hEsDUvJ5LBnUqpqHvYAJCxAeSZYZjJFYQ/p09SBr+z0nZz9f/mXj
         zSSA==
X-Forwarded-Encrypted: i=1; AJvYcCVa8Hkvr4oJ8J/F5xlHNwRoTeY9fwDJWbv5mRXFoiSxlukTLgs/vSKt6yaOrZKyjhIqH06YJW9WroPhfHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kNgCD4MfDQRXvLVlUYQQH7GFVXU2KsWSQrvJ832lnvCox70B
	Ewb3hK4csnF5k/tlN3MPJKFM76N2jq2tXRvvlm8yHTuPQI5zk3hbtepodNqKXEYYoM8WSnA+ttj
	8OFB5T619i/IG6V+t8wdzRbfKq9JpQ5E=
X-Gm-Gg: ASbGncsbYHoSH6HP2df1SsqtfIRdH5mO0OqO5XtYc1CyZaLnmkKjWHiP18ISrQJhwXV
	8SwhU9pLpCI80hgd2o3O7SgV3YOAeMNqF+XtY11m72DpSsBxn43l9Eq43H6wfheQN+GrDVeQ3XK
	zEtWYU1KYSEk3TKuvTww9Ks8W/dssfcSzgS5pFHgsp0IduKEC9OYmcIuaKxzOexp26Jk/8CzpgV
	1rUH+kJ5mwk02YpKQyUrSiHR/r3o6Wp62dGwIRNaw==
X-Google-Smtp-Source: AGHT+IE7wq0GTfr6Wem0mYNTlAkaEzK6ipA0S8kzfZ/y/0u2+zPT1QbZBuaSGMpa3xSoErIYIls5LtEWpgjFQsU+jdc=
X-Received: by 2002:a05:6830:2b1f:b0:7bd:cfb7:1853 with SMTP id
 46e09a7af769-7c0df80b567mr3334934a34.35.1759958970922; Wed, 08 Oct 2025
 14:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com> <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
In-Reply-To: <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 05:29:19 +0800
X-Gm-Features: AS18NWA6fff2AtJtJH769wFOzOwXshBwzO7k5-SHU66b3SSc8BXOaZvpYrb_ykY
Message-ID: <CAN7C2SCkdFCCnNwQ+HEWNb4W7fxdZt8xC4DEUu9YWOVae5L3Uw@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:18=E5=AF=AB=E9=81=
=93=EF=BC=9A

> 1) Because you can't generate the actual BCLK.

If you can't generate actual BCLK can you generate actual LRCLK
on this codec through the same MCLK?

