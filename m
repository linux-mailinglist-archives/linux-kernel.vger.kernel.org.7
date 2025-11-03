Return-Path: <linux-kernel+bounces-883065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34988C2C674
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC04E67E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5FD3126C8;
	Mon,  3 Nov 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPXnjccZ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA130DD32
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179968; cv=none; b=oeW1FUpZcN4VAMBGAzYgGfp6/fyKb3Neni6PiWegKiopkz211toqWgpBEXezpGh5wD0wJWpF83Vc2g3rx+qczFyz56hRA92RzCpswe19trYKBJd9xNDCKZ43bfOzAdeaBIwTcfrsvo0Petf8ZPuyZDQOVLzLVMdSLVqNaOs88+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179968; c=relaxed/simple;
	bh=K78RWkk+rgbWnehNDeAYSAUzgd9AWm27AyEpeGRwU2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKAFWYao3m10o0BO09klfzt1o8/OQESxUIolYXW30d2AOcZv5pALa7a6RSWWZZWrNzegFlqS/OtYyIgYeKLRtVoywomF2uZ75ZuRZWoJZ/7yMbSCYRvqQQtenEMOFUeJtdoG39aqfcOTnwgvY9HPPP4cU6rEaza/ZGR+pnK0VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPXnjccZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-73b4e3d0756so61142627b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179966; x=1762784766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5vG+TpX2vimjAShLENqDDN7PpdggEkGS6lF5Y2WIW1Y=;
        b=CPXnjccZOaBIKhfIVMSv68iYEaUZULispLeGTJ06a7jJtMD4dRM078/ZueAC4JLP8j
         SbEf/aASwqwz735LpihdL72POBPG5AirLdyfgBP/2wzuZudCsuef7OmDE+XWvoF51PhY
         6dgNum+hyOX1f4Q/i9Q6533t+KfN/qw+wWWpzJVVaepkEL0+zYgGJayeKa60W8EhC8sx
         BJdSVXspMK6ioPiFwQVrzvwuLHvIpLybEFeWfaSbVLwt3oJ/NpSNLC7pbcoctFXjUqCV
         7EWhcw+RTAI+4z93K29PNSRr12ImKNQi0RKIJD2zusHgf5BMRNQc0q7Gt+aYCBHKV6fl
         v2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179966; x=1762784766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vG+TpX2vimjAShLENqDDN7PpdggEkGS6lF5Y2WIW1Y=;
        b=GL1oL/nu+VDLuF6DALc7zPd1fH8r6NlaJILYR7/Z+Y4PoXsuAUi+5p0wS3jubLt++O
         XmWcJPgTtNQtrzstdBR/TApBDgYDPVS2tJUkrTS3nqmipfCInrPFcepFmn2+pJ6UNsQ5
         yPIIdOXKGnHl1UyehM1yxKeQKvaAiN7i9kZmDghxH9EQ0GBFzsxgHPc+J4vAcCGFan/X
         kWjX3A9cOou4adsHAKwPbUw583PN4Uu1wbABhq6MUCnyzmdRb4JBbNh3YrXyfSOT/Gn2
         u1LSN2cw5quGNd4SMxXduJqb8CTVUsVb5d4CrLkCOID2i9o5EqXbAAEErvIdnlv8yjqM
         60EA==
X-Forwarded-Encrypted: i=1; AJvYcCUlJ9xhmcGu/7ngBFibrJ+j5ORpckVEZ/7jmUs0sX+h+bLZUX330umG1MiDOc5Sp7SgDFx1m5QV31qqEyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dW3Dk2B9t6T4tDBOLGyZeeQxFR3HbyNUPZxFbWIp6WR+u+m2
	qA8ll/kwIIC+HHVuh3ZeIINL8c8gSh7EERCKWc1ZZDxLBeqTqPOvEYh4
X-Gm-Gg: ASbGnctwwkdn+DEzKNvlU1OaT1vwYL/6XM6MVfgrwB0Fmg20c1obG9HHT3rTo8PjdY1
	3k37plJYJSEtiwGEQBdnSQFcqyp2AdKCVoApH+M6x3AsxS+7ToSYK/MMj26FhD5kR5FCx7WtMZt
	KURVecvFFOI9lFmkonlpwFr4WsJd/c0yfUBk/wAu8x+03rKtahtRObyNEvkuGTlbGjL1LRmRmlM
	0p0+HY5yRleTfGagEvRvie84mvHMqPVZ1W9MWOtXrBAXMlvpKKNWXbIHqbZpSlMpPFUUfp/G9Wa
	pNkG5u+x7z+KAinCAeXs1YgHNHi1gV0tPczvR6CIXD9Z8iw6oqp/+RgGq7pFiaJL4z9CQcaXXIc
	ZQW754VPZ/3PlP6wvdY3ZrqrVWomEcc+QgcAAXWA8FcUPBcjydnqXpvzFZ4p6RMU1HbRzPHwwDq
	krMwAAPN0LIy/DcX7yioqAfUu7tJdC9fYmgus2gW5zKTI=
X-Google-Smtp-Source: AGHT+IEH5jdLQbZho/a8RA7nF6g94W7FdJWsuNNVwBRPPoQkHp3BskZSgwf/LVFOw8f9zQEGt8nKaQ==
X-Received: by 2002:a05:690c:4b88:b0:786:59d3:49da with SMTP id 00721157ae682-78659d36da7mr83652737b3.22.1762179966040;
        Mon, 03 Nov 2025 06:26:06 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d8f62dsm1071397b3.10.2025.11.03.06.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:26:05 -0800 (PST)
Date: Mon, 3 Nov 2025 09:26:03 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Message-ID: <aQi7e6VgFsqpq1Rn@yury>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
 <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com>

On Mon, Nov 03, 2025 at 03:10:01PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 3, 2025 at 3:17 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Rust _must_ do the same thing to at least be arithmetically
> > compatible to the big brother.
> 
> No, Rust doesn't need to do anything of the sort, sorry.
> 
> The point here is not to copy what C does, but to improve on it.
> 
> In particular, we definitely do not want to have anything like integer
> promotions and arithmetic conversions from C.

This is exactly what the patch does:

  +/// let v = BitInt::<u8, 4>::from_expr(15);
  +///
  +/// // Common operations are supported against the backing type.
  +/// assert_eq!(v + 5, 20);
  +/// assert_eq!(v / 3, 5);

