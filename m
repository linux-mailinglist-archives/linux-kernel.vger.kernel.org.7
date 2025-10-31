Return-Path: <linux-kernel+bounces-880181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF0C25107
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEC8C34C95D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A834B1BD;
	Fri, 31 Oct 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4E/e1To"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF32550AF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914689; cv=none; b=LxLnkpJcJhtoVRl/CYiUbxe40u4Yexjv87Q0y4AbvEtcFNXrHw/47pMCJ2PdvQG1fpngT1fbz64Ux1NIeE1fn4LxyZoTY0PTSIm0zEBdY51TV6Y0VmAuZQFwW7t1e3K/+OQFBSYRzspNVIk5drcI7UaNRV/zv2nR3jcxBKBhkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914689; c=relaxed/simple;
	bh=CvFGZtOf26dYUowBbWluZEW4m1VkUdBhmnfG6Yu+Vrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ak+rywxB7pEo1m8/vMAurlcUf3Sa43US3PCdaXk9i0rT6jKVD05a5oSeUxXYdV4pa3k6yCD2mzW7wU9co9JCkOy7AXzDRSE0gWOS21z6rXwSsrCH90oaUUo4FlpdaaJ8WzsBHcmIn98iHJJlJe6zN1IiDC4zI23hZMQGtUDeW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w4E/e1To; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b4626b2d07bso149990966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761914670; x=1762519470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvFGZtOf26dYUowBbWluZEW4m1VkUdBhmnfG6Yu+Vrc=;
        b=w4E/e1ToSxACHbjeiQQRoiGgPJTsQwcGVaJ4BHnpDrbdK22SkM32KW1iyPAyuaPC35
         Qs+MjHhxgppVWencfKCudOl0gzfA9xWBR9q6c04Y0/WRaBqED9Zr47zKM3vCauqBlX9D
         +puIsFL1OIu0Ry75ONG+s1K0zlzq8QRMnfajIdI/mZK83CNUHtRSbr9IJ9ipWBYOhFej
         HTUDK0bgJjfQyGip9oId26ih1AgMRSwyVt/xMwn2kT+1F+3h+ZSyc6nRbrEYB/MvR22Z
         sTF5nFwiqr6MbDpwa8wjiQqPk25qGIJnkHJTyeWTXEJyuwnvXRht+mBZhB63Jn43kbck
         4mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914670; x=1762519470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvFGZtOf26dYUowBbWluZEW4m1VkUdBhmnfG6Yu+Vrc=;
        b=UzFQ1x0qt991zHI9NR1B+/PjWZwfeyt5iMPZM3M25IERlKVuGKWevbsPeIf2qCuQ7v
         H9iYetlDxt6fVkDH5Hr5T508caoHkKa8zHsCSsQecD8ffGmBwjUzi6RPjizoyzyyeYWK
         wwaOzzwAD57FtFeh9RxZyqdd9qEys3aZvt1oYFKabi4vlRI8+hZ1vEck6PaXYXsRKhsB
         04mIEOBXOHj9s87S4ADTYSJDbt5og7v0FLblu5TafO2aJjCMaBrlWjkPKO1nVRlpZkga
         LiJGv+kCy38Hlu6vDrIYh5BCwPkSXEziLiw3ltisdWJxurxSt9qxfRR2IXujnWC3gtki
         FnUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWnGyjAz7csNYSe2mRHWPOh+h8ZdYkHTdt4CaCbrBux/fURQgt+8a3/4ksvhpjYa2NHOu6RdGZLLXwoCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEvkmHYErleyQleUc1nsCdrk0OYtm694hU4gB3mB4W/+GUDGI
	HTlWEMUf/LNuJXw0Od9b1UWst1RGcNvdr+Ql0QwCffdYIOGZY4HCuE5CNSDk/zixEpmBtngYnT8
	2uekcjI3eHKWzHQ==
X-Google-Smtp-Source: AGHT+IHU8weZjAEhs2IehgqJcwvwtB2UGWE4Em0q57RBbrPppiWnDSvsBrl9MlsbTlimASqXdDTHfslYBQ30Kw==
X-Received: from ejcsp10.prod.google.com ([2002:a17:907:394a:b0:b70:4a91:9d5a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:97cc:b0:b3e:e16a:8cdb with SMTP id a640c23a62f3a-b70700db192mr431743566b.12.1761914669956;
 Fri, 31 Oct 2025 05:44:29 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:44:29 +0000
In-Reply-To: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDWIMGXNSBHN.3LI1W4BHB75W0@google.com>
Subject: Re: [PATCH v3] selftests/run_kselftest.sh: exit with error if tests fail
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: "=?utf-8?q?Thomas_Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue Oct 14, 2025 at 2:45 PM UTC, Brendan Jackman wrote:
> Parsing KTAP is quite an inconvenience, but most of the time the thing
> you really want to know is "did anything fail"?
>
> Let's give the user the his information without them needing
> to parse anything.
>
> Because of the use of subshells and namespaces, this needs to be
> communicated via a file. Just write arbitrary data into the file and
> treat non-empty content as a signal that something failed.
>
> In case any user depends on the current behaviour, such as running this
> from a script with `set -e` and parsing the result for failures
> afterwards, add a flag they can set to get the old behaviour, namely
> --no-error-on-fail.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Hi Shuah,

Can you take a look at this?

Cheers,
Brendan

