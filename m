Return-Path: <linux-kernel+bounces-846354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32185BC7A89
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18713E7D23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86695298CA4;
	Thu,  9 Oct 2025 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZzCF1Oc"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD627E1D7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994290; cv=none; b=MbG02gl6RiHeWvhsw0HEfFcDUHb8TadtUrPxNdlgVs3faMYanSk3viu70XYCB3TajrQh7QC3MB5mUpW/8ZdtDR0EcZIgKeY4uU+Omz4kzAYpeDYBDk1271VKpFhKiwwhnzZtBJX1Bre3t+3kXXLtBlHHkidDGGKnP4JAWYDVrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994290; c=relaxed/simple;
	bh=l0XjO1LRI4uEkXnlwicCc54O7kgNZYHrpfgu1H+Q6z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAEUzYGSVyM3uHMyVqoEA9cMWc2B3RyBcQoLhioIioGohphXXQhev68dkjTz2RrMh7CI89zNZC/N8u+9du5JsCIt7+CAnkSKhLr3sA8xsOHEiHf5Z+jrMyr1WR2I/d6Osqk/Ie287nqBo0OaZZ983KOpvE98zbZWIT9up3JJYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZzCF1Oc; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-633b87e7b9fso594116d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759994287; x=1760599087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWMjgmVWGYB/ktxqURYjHTxYJNRdD4XWmL+oG3oW2AY=;
        b=QZzCF1Oc8IkCvPZLtxJ334wm40kxoQx/njuNkNWGxN0fgubgH9cC5BZ1DQiIIwmBn6
         yQRY2rvO/UzrAZvEe1WqYP0CgI7cFD/muR/Oj/3wXbP+jk5S5pkL0qOKHkJyjaECjZxt
         9KrJxJiswPv4lH2HmmeLTTFFgka74k3SkMMD1lk7cvbF1tmUOMiN0u5Yz+JWorlmxdyN
         aeK8gPRgGfseFyIvHNxiav9UBL+TzTVOd7vQkWmSDfgvE5FP1FEPrl4wOEEX9oMJp0TT
         EwUQLLo6GMD+yTstVzz3b9oI5jbnE9kEqwlr2U6ouTlLji6OBfeHkUBiI6Q5W9icImQ/
         3tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994287; x=1760599087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWMjgmVWGYB/ktxqURYjHTxYJNRdD4XWmL+oG3oW2AY=;
        b=a/ShWor5Mk3HrPusZBTMI/Q51ZLoNvC6eEUTt0aI2/52C0KgvpHZOudhVavQvz2aI9
         1LwDlh57qX9CZnU7FhivOffFdZXuh6RkRsgaRgf+vgNnyjtXMYTFO0zjU5eix7FyVvOK
         3hEH38fezfe6zv51GLRfff6gyZtd2UA8YqSADsMGp00ryHW3ASARxQ6r8BgBnTwFBvmu
         R4lJABT56a0HmiLOkKZEIRlHis1ila6KLhtxNn/3crF0XNzZyRpmu62Gci0zHXvMpFYx
         gA63cShTxuVHqjS6pNRG9yltBukjrz7EEcPAssQmGXpsY0/ouEF7YMC4AIs9o1bKeURL
         N2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXfI6LoIV00cYMd3Qt6nb7YhAR3hy4eq6gZihuVAUBz/cemeU2xDfADhYzj1vXGNOkdP9d9vy0mGftoUVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6MIjrzJflP+Zi/qlfPG9jU3htKH30LJaH90dOmiS0aQkwN/i
	I3SmkJZk9kWeuiRLErj6beM1ke60YVzSLYhbpUCxO2eCPp+BdM/VmpPikztuhxODo1im7rQ/rlS
	uHt32l54gfkpNMGV2aGmlMVNhf3MXe0A=
X-Gm-Gg: ASbGncs5EOWkp8ofhA8byvOPjUUK/0gFaq+YQUmr8SU55G33MFCIT0F7Ge8GDwnZ7CR
	Wd3Vv4YKQvDuWTdYj//nKhTmFSefJrIDOZeFA3UOw1RrTTk5O2Zk/0FwWBo7sNYsMvJsvlXd50f
	RngF/UmKhd2tZMt3Ofbu8/K+5WDr9UFxxm5kmiSaDUg7PNb1K61HUGvWpZzgxoNSW+Gcz9YH/Pc
	eInoCkEqvLi2cYhxF+KmETrXKfppg==
X-Google-Smtp-Source: AGHT+IEMPH48N3GSuwCjKzVOMOzHl1MAl1J5Smsbn+2oKCoqUAAt8XvDaV0BPh1/dqDU/ac4NYG7hKrwiOcGph5xBJA=
X-Received: by 2002:a53:b702:0:b0:636:d691:891c with SMTP id
 956f58d0204a3-63ccb940b87mr4683440d50.53.1759994287231; Thu, 09 Oct 2025
 00:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759988849.git.focksor@gmail.com>
In-Reply-To: <cover.1759988849.git.focksor@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 9 Oct 2025 15:17:41 +0800
X-Gm-Features: AS18NWBKXaPqnallh0PohHHV41HShX1g9UVlu25s1Tqjf_1cAuEzwAgqUKtKXUI
Message-ID: <CAD-N9QX8GZ4KGvdRGjptx7e8Bsa+rJtHjLQzPRNfYDPjVFOscw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] docs/zh_CN: Add trace debugging Chinese translation
To: Frank Cen <focksor@gmail.com>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 2:04=E2=80=AFPM Frank Cen <focksor@gmail.com> wrote:
>
> fix RST title underline characters for proper formatting
>
> Frank Cen (1):
>   docs/zh_CN: Add trace debugging Chinese translation

When you have only one patch, you should directly submit this patch
other than the cover letter + this patch.

>
>  .../translations/zh_CN/trace/debugging.rst    | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/trace/debugging.rst
>
> --
> 2.43.0
>
>

