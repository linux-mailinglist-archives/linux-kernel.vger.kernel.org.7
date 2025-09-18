Return-Path: <linux-kernel+bounces-802652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF69B45534
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F691CC4841
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F32E2F08;
	Fri,  5 Sep 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhxCNTo2"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD322DFF19
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069065; cv=none; b=h3jhc95t8fsSJSYaDrcvABH3/LjkVQAM40aF55+g5RUnPpJhoLfyD8dqMOk7EbFLc65VhYQurXlCBPPDYK3l78ba2O5JSwAzDh7vV2jtorLWwwza/cDLvZti447ktIwVtk2IhDocGhEGVVH8WxCtgbXJHAGvOGAW3I58qnCbdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069065; c=relaxed/simple;
	bh=NtnJqjXAorb15shsffdIRrs7Ou3F++wwVVUu2U2mphg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdlxfxEP4QBuVQsS23nCJF6zcz8phqYhNlAcuKhxxKn7aAqo8chmDuxhw+yatrvJWbaGNceDfKeJ+arr98I1GPU3uYE61B7eFoaBOMhscuAV1uTvk8f7rWXVKHzZpm6DEVMRe9A7gdX7D4sYITIrjA9ICm+VAMw4juI3JmBve/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhxCNTo2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7222f8f2b44so17279436d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757069062; x=1757673862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ18ogS6OfuTP1EQiRfSY6yIXK3vsX3youWzsSBm03k=;
        b=HhxCNTo2H8uKzqXAwJJERo78tpmIdSJPA2NlgA5GcPfZGz+2hvXRqV376w3Hs9fLj/
         EcPpQiW6W6TGzXl7xIcgsvNcXNDFja1bHyX0CIi7HKNl2Kt2HNBY35JDaHmkX4sR5xrW
         hFSh/dMoAiE/fMn+5jFwJmgpXd9/fxhsHZWMdpXsqOWss5obtS9qSXGbDcMdpkLm7m6t
         HyPB9oNpxs04ISRKu44eZVUFJmFKc8ypbzsddDpcRlP4tfSSBRX2/PNXj6bD7MMNxC4e
         2Xf+2wUanUCFpgf4hi1H9GYrjYbeHLSWAJ/MCOER2OdIs0P7AkUT4/cycHepJhO/nIyg
         XVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069062; x=1757673862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ18ogS6OfuTP1EQiRfSY6yIXK3vsX3youWzsSBm03k=;
        b=MQfyLYmv5RIk54IyKh6FCmmkxNEVyaMPH6yMlo9CsoEOP1/x7ReDYVCYTsj7Imw3ce
         pPKxnBxr7vOxfYq09AFguGns+rAEqPHqVD1DWwElw7KKBTpBRXqF0ATrhigamWmEBjIn
         OiYD5iLMZ+e/h0fMWajG04fsGGyKWkMF73XMSsavf1oEZ2lmKZw5saG4HA+di6NhyVoP
         41eFz3tgJTMictbVl3c0uKXA9NcoZDN8pfMyquGYORXKnN9IByjkyvZFW0HhCCPMKRb3
         +iv+C3e3hv6Ut7+6y2p9MW8LHE68DofiycPcWq+wYFTGMEFz+ehJHRoo37xIvbDr0BYN
         xQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnOv8tny2Vq4wOqBiUwaOBn94C1zX5Lk0X5mkx1cAjtZVG9pzMTDT0nE5w2g1a2UsvkhRiNp9jpvL8u+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj81mz4I0GslaDZfUw8Bq9RMUS9phTCuAJkN9igSryLPLyAjdV
	qt/kgiGEVYrPy/XiA/EVcCRAZ/ht0LMhJR/gslU6GKvztzYWk1D4ssUtyDCU063dM/j467qO8ta
	G6O2xHFrM50I6LtAaiZrSTe6/KvI5dLxWJRMlOr6D
X-Gm-Gg: ASbGncvVciisFAD0ccA4YUW0Y8Y1Wa4ouRytP4CLHfBN086jdjUb0DxmLPzetNT8z1a
	4j8v1R92hO4T7NVyYMUauFs1r1BqnKk3kwXV+FadxqTbttsQ3WwmtAaX0DqE64CIS4nk/wtaQ+B
	d8H+x4ilrxGMk20F/OscI/tKg5sB6ViMZv1y2d41TV0F9OVl5Tu4CPmPOSDjm3/qWCsRN8Dm7My
	T3Ofloy8zmkm6kkelARDmomGJ09Wy6y/nUlenJOwAtsRMLjVu9pq3ZdhCQEU/iPrQ==
X-Google-Smtp-Source: AGHT+IFgnVn5YPd7nt++mcxJYKI5s6CE63gp8oAepp7Bb2RS8fbxpyACzBXy7jLF8rTFHvYVBXrZq9tFnSqmoPRojvg=
X-Received: by 2002:a05:6214:23c7:b0:70b:a189:a571 with SMTP id
 6a1803df08f44-70fac7a01cdmr71754206d6.25.1757069062247; Fri, 05 Sep 2025
 03:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-5-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-5-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 5 Sep 2025 12:43:45 +0200
X-Gm-Features: Ac12FXwrVWcwse0FO0oj90oXgii4UalASzAKNOgq4n0I9KmYMeRdWc12CPAmKB4
Message-ID: <CAG_fn=VXxaGd4QC0jHzwFg88HuaOFV4K+_tdzrhqW+UoTk-L6Q@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 4/7] tools: add kfuzztest-bridge utility
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static int invoke_kfuzztest_target(const char *target_name, const char *data, size_t data_size)
> +{
> +       ssize_t bytes_written;
> +       char buf[256];

I think malloc() is better here.

> +       int ret;
> +       int fd;
> +
> +       ret = snprintf(buf, sizeof(buf), "/sys/kernel/debug/kfuzztest/%s/input", target_name);
> +       if (ret < 0)
> +               return ret;

Please also check that the file name wasn't truncated (ret >= sizeof(buf)).

> +
> +       fd = openat(AT_FDCWD, buf, O_WRONLY, 0);
> +       if (fd < 0)
> +               return fd;
> +
> +       bytes_written = write(fd, (void *)data, data_size);

Not casting data to void * should be just as fine.


> +static int invoke_one(const char *input_fmt, const char *fuzz_target, const char *input_filepath)
> +{
> +       struct ast_node *ast_prog;
> +       struct byte_buffer *bb;
> +       struct rand_stream *rs;
> +       struct token **tokens;
> +       size_t num_tokens;
> +       size_t num_bytes;
> +       int err;
> +
> +       err = tokenize(input_fmt, &tokens, &num_tokens);
> +       if (err) {
> +               printf("tokenization failed: %s\n", strerror(-err));

Please use fprintf(stderr) for errors.


> +static int refill(struct rand_stream *rs)
> +{
> +       size_t ret = fread(rs->buffer, sizeof(char), rs->buffer_size, rs->source);
> +       rs->buffer_pos = 0;
> +       if (ret != rs->buffer_size)
> +               return -1;
> +       return 0;

Note that ret may be less than rs->buffer_size if there's an EOF.
Keeping in mind the possibility to pass files on disk to the tool, you
should probably handle EOF here (e.g. introduce another variable for
the actual data size).

