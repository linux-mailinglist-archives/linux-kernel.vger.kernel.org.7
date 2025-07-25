Return-Path: <linux-kernel+bounces-746276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC0DB124D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F29B87B45B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA224EA81;
	Fri, 25 Jul 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2OEFL+x"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714EA24DD17
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472326; cv=none; b=ZwXeNMj0iUoQbe3FAkGHeDxKrsb6tSvmNoYAPuUQja5MRNVuRH+u6mqETxMtEvacjLJFCu44ko2vlUdi3quo8HrKa3FguqquWqy4za1C8Rsf/OJgxwTKcGl4l8LxN6E6qINhSUvWw9pmQLzpjPBNVJR6RJs+G6HFYTr0aeO5dZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472326; c=relaxed/simple;
	bh=0U8jZnzxuZA1tVrfiKEgKXyvzROUXp4d+/idfSXvLJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNnlBtKS/VtpqEu4UUX9J/7S+jC9rJyDxLzlzk6biu8pnxb4Ez7xkmRLogBhrW87XV/0ODQNS70sZJxrMTBq/FzYbo6sRrRq/3BZApJfaiIRa1dpG7KxnEd3Lh8aoo1+K+9wLYjZ9yIyDD/dumdadk0xI/+NbZ350dzDOJE/NR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2OEFL+x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2357c61cda7so3135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753472325; x=1754077125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ksKk4N7VAB2RT7FxkAzeyCRXd2hVmXGnsI391aLajc=;
        b=j2OEFL+xq2CZxVufAnPc3xl/9qKukCcPcg9GegPpRbA7ZgDjqJN1ql46/f7kqd7RKx
         bqcIlIDRSrOv4BZFhu9gIYIQLFkHArm5QjjDrCJNLjCqIS5xDAKPJ5xcCaSMzWr7Mn+O
         X6lUlqtfkZczLTnvlTp5/nVPYpst8JTQe6sHAhQZIsckXcAm2NHfmWc3Ik/tyyGsX6Qt
         z5c5EbcH2TdrN6/Pxv4tKBP3OCK8A0KdMBqa43n1QlJ8YrE5KDNpcw7ZVh0pHkAfUaGp
         eRkGMp2eFtFR+HOZDxVYCT2NenqkQris87oC6n4LoBJ2pEdjfTGRQcTEk1u+xXy0VGCz
         lVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753472325; x=1754077125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ksKk4N7VAB2RT7FxkAzeyCRXd2hVmXGnsI391aLajc=;
        b=SJxM3nnvQarHih7GW1XYgQ4hmtdG38YGhBz8v2bmT/02zUMbBBfG5+FdouweCjb/C+
         lKD+W9263PfaLuTuEAwGDEM5N56i6/89kW7pX+nPpNsfxOgjVTa37He8gMO26vYS0lmb
         wZfhT8GAgqsfTx8TbBnEIZhsaIXQ1b+UVko+6vHOQmglPDsNBF97rztfI1FxdqrVe2wj
         aakzp7kL9tOFVv+qv7TJYxwMgqdyytc0gOp8x0EobiIpXGbL8JWkkn7QQD4WZAVHxpAD
         DjyhOmICFZtjyubnHQdNURoHmkP1nmmOuBKW93dT/4zSz+5X6wWs9jG0dUUhySUamb/J
         IjGw==
X-Gm-Message-State: AOJu0YzFLp9aQBKZYRHZzLJ2DfovgXGKyEs0e++s2+NV9x6M8a8Sk5yj
	QPL5CzkbAar3pKMpQD32pvtwZXKIRo6trpPpk2srV1Tv7Z3S7jqYtnW46GhLZhO8hQ==
X-Gm-Gg: ASbGncvgD2TTytwIQpUW9HdwVSmTPyPJNksiCpO1n0fHsB+3hZ/WKgKPsSH2TiJg1hi
	Fw5YSdFeOQG1eISeqwDdWbRH8AQO6KIijrGlFzNs+9Cxyn/P4KrogOCE3g3S/QLNJWVRZij6tkP
	n3QMIbERB0itDfx0/93epfRSs6Lmi4Ie+KyUPbCNDRSQH+8ZwLjSZiScsdHgRXIhm5XCVqNl2+z
	bk3OG/JvmCSZunJEDYsbOq5TruvkvxLZy2YD1skOzDWY9UxCHrpfzJfXmutzW2wjZ/CoJ6NuNfx
	GhPapfneHz+iklDJW6eso/XRB3fOzDrHgbQGqQdG4bFt3Gaw7q7OY5z/FEvyctbWfej4AGP7jRe
	WJuhooiYMbyr2yaNt/ZgZ9tCx10d+GURu8XxSuGhNGSdmFxWS48kJjXzcx4FQqlw=
X-Google-Smtp-Source: AGHT+IFfYrcutWBv+S2QesiSvzMkiyMNlezGMeE2S3emOBlmLD8IDRCH2dhw4tCU/ByCu0xXjvhvDw==
X-Received: by 2002:a17:902:ea10:b0:22e:1858:fc25 with SMTP id d9443c01a7336-23fc005f89bmr355275ad.9.1753472324401;
        Fri, 25 Jul 2025 12:38:44 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d18sm425755a12.11.2025.07.25.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:38:43 -0700 (PDT)
Date: Fri, 25 Jul 2025 19:38:39 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/2] binder: Use seq_buf in binder_alloc kunit tests
Message-ID: <aIPdP5d6mNRlvMyq@google.com>
References: <20250722234508.232228-1-ynaffit@google.com>
 <20250722234508.232228-2-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722234508.232228-2-ynaffit@google.com>

On Tue, Jul 22, 2025 at 04:45:07PM -0700, Tiffany Yang wrote:
> Replace instances of snprintf with seq_buf functions, as suggested by
> Kees [1].
> 
> [1] https://lore.kernel.org/all/202507160743.15E8044@keescook/
> 
> Fixes: d1934ed9803c ("binder: encapsulate individual alloc test cases")
> Suggested-by: Kees Cook <kees@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>

