Return-Path: <linux-kernel+bounces-818911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB4B59801
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FF87A7466
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9432BD015;
	Tue, 16 Sep 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZQA0uWb"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB61315D53
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030216; cv=none; b=Zut6GSJ+Ym2aRfEXVGKV2wCTkJyf8MHXDDRCXbh5l9ZK8KpwjOavzaDJyP1TCTKbnTU9M+3TXPaRel3PrUP0MSWWs0YYqA1mavZ0owpUsjHYSTjCaIFYeTOe67MnivuO43NIdKWqEsGOCN5ukdiRHgGSdC68sJL2vUz56JaQgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030216; c=relaxed/simple;
	bh=XWPXPFwYPgFopfyxu3zdVrQPwiTk6AP3tAMpPe1ARK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWAZJht1mYCNf4eYhRB1lmHWTg3RXjnM4/3+F4fzJ9FnKaooFSjxUHVY5Og82ZtLRXY5MMo2YjN8E+id5IPQ/0rIh11XO6qXhQDyptFkK+n9soPEKrI1guadhTM3MUBh5byIxCnK7UfBuutVxjAjiPuvGr5hdLLg0FuAWB82hPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZQA0uWb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78cce797cc2so7338056d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758030214; x=1758635014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFMguP23bZIISRu8P8L8i4YMMkZ2fq1VcnZsxEVckmk=;
        b=JZQA0uWbAebE9uTtErpjBQmOiUOvBHKv9zZQql83gbMxXatkIvd7+iIe8bc386M0ZZ
         RCq+tmKhP4feCvsvUL6eEV8Do5jppsERIGDLmWPVwrwenHkt8PGPgIfNe0qxwsdbiJBW
         RWYhCDmzO3wyvTBNEcb7yNtKhghpPS9PMZvYsackg2jpv35SPsw+3s5WlBvZ6vUE4lOR
         iFvgEc+i78nYmIJZRcD36X7GXz29PxdpBmteFV7TgdkayvutWfCWE5HKJEEZT/kw5CYT
         bCueslyFoutPm3bqeHRtM9ouK595Yiy2bxmmDtxER4DNJHKIOwx7Xhs3qXesvs5/WMLQ
         eFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030214; x=1758635014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFMguP23bZIISRu8P8L8i4YMMkZ2fq1VcnZsxEVckmk=;
        b=fCB02cAgwbzNnsk+HsfTRRRafxH17ZI940WJ/E8QEZLlN9nBTbKaMuRfmz6ufJrrjq
         Zk7FjIekOrHccF3a2gSEtxBMy8D6fr/UcWKA5VV30zQIV0yuOxF+DCH4Vc3tfxAAoXav
         Sb1xRcmtirn1S3jPAB11jJTxTR7D0PdtZ7U3V2ZpMp7tPar+VcgyxewcrpN8nt7sIaru
         7tIRtklHzMTnUvO8E8L636ghBcqUJcEHyGbE2ZpRDDdIh+Lg1TQrSnUXrQw/QCnbFHdd
         nGr1byxEBEiS+GW4NyN3sMaDYfdazbL/yALandzeWe5elhhrWM8ijQSt/sUffzrpJdAi
         egLA==
X-Forwarded-Encrypted: i=1; AJvYcCWqGLsxjQp+XfIJuxX47RzL1CUTVDcit/fNdCwfGmWc1JTiWPdIDR4z0fbsIa2N9DF2zVLNJsAEWdsz2o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSs6pqUROI0j9WoT2mK7J1CBl42Npwq3Qjdiv285Ai6eDlc+6b
	SSWmifi8fBXu38D8BAc1TJSRvbx/bNHlWyjWcsl1OC9c21tfuv2oGSgp9IVAXX4xbVi9Gng4Q+y
	Nak7IVot1arKpE3vBjfLjuzaqlGYWHV8JzE9cj+Un
X-Gm-Gg: ASbGncsRjWn1qMPmb41i6OZVUrUr4EChuRdWDiZET+H7kgf7NRbo8evTeNNVex+wrhm
	pYygOpiRt9KWQUuv6f0d+i20nnzIQs22M6JjgwYR0LPI61DbYYkgYjFLECC4LMS4lWzbhLich48
	ThB0GqO2IT2HptA/XscZaYl6OICiDRERWRcpzgLseREZhGXfbDaSdCvNV0Cy3faxpQZy8LUX07m
	lM7cHQfmi2GQ/H5Tq0YdK5FRXAlkM/zXQ3kP6UpVVj/
X-Google-Smtp-Source: AGHT+IFhDI3DiXQjQ2M/pDauu4pj8WaE92jep/q+QEEg6eNCMk/WVoS5e7N/U3EzJP+zE2T6dly3yK42LO8dPZ3MnPk=
X-Received: by 2002:a05:6214:2624:b0:71c:53c0:5674 with SMTP id
 6a1803df08f44-767bb3b5cc7mr189377726d6.7.1758030212716; Tue, 16 Sep 2025
 06:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-5-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-5-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 16 Sep 2025 15:42:55 +0200
X-Gm-Features: AS18NWDFPFWnjGnn0Ya31_ptvZRyrk4s5Sg6fkIlAJtVA6vYI3uU8Zv2xeIdCLw
Message-ID: <CAG_fn=UJsV1ibxSf6D+QU4ds1mHUG77NWJ5TR3sVs3f696RgiA@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] tools: add kfuzztest-bridge utility
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

> ---
> v3:

Please change the version number to something like "RFC v3" (here and
in other patches)


> +
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
> +               fprintf(stderr, "tokenization failed: %s\n", strerror(-err));
> +               return err;
> +       }

You should be freeing `tokens` somewhere.

> +
> +       err = parse(tokens, num_tokens, &ast_prog);
> +       if (err) {
> +               fprintf(stderr, "parsing failed: %s\n", strerror(-err));
> +               return err;
> +       }
> +
> +       rs = new_rand_stream(input_filepath, 1024);

You need to bail out here if `rs` is NULL, otherwise encode() will crash.

> +       err = encode(ast_prog, rs, &num_bytes, &bb);

`ast_prog` also needs to be freed at the end of this function.

> +int main(int argc, char *argv[])
> +{
> +       if (argc != 4) {
> +               printf("Usage: %s <input-description> <fuzz-target-name> <input-file>\n", argv[0]);
> +               printf("For more detailed information see /Documentation/dev-tools/kfuzztest.rst\n");

This should be Documentation/dev-tools/kfuzztest.rst without the leading slash.

> +static int read_minalign(struct encoder_ctx *ctx)
> +{
> +       const char *minalign_file = "/sys/kernel/debug/kfuzztest/_config/minalign";
> +       char buffer[64 + 1];
> +       int count = 0;
> +       int ret = 0;
> +
> +       FILE *f = fopen(minalign_file, "r");
> +       if (!f)
> +               return -ENOENT;
> +
> +       while (fread(&buffer[count++], 1, 1, f) == 1)
> +               ;

What's the point of this loop, why can't you read sizeof(buffer)-1
bytes instead?
(note that the loop also does not validate the buffer size when reading).

> +       buffer[count] = '\0';
> +
> +       /*
> +        * atoi returns 0 on error. Since we expect a strictly positive
> +        * minalign value on all architectures, a return value of 0 represents
> +        * a failure.
> +        */
> +       ret = atoi(buffer);
> +       if (!ret) {
> +               fclose(f);
> +               return -EINVAL;
> +       }
> +       ctx->minalign = atoi(buffer);

Why are you calling atoi() twice?


> +       ret = malloc(sizeof(*ret));
> +       if (!ret)
> +               return -ENOMEM;
> +       ret->type = NODE_LENGTH;
> +       ret->data.length.length_of = strndup(len->data.identifier.start, len->data.identifier.length);

This strndup() call may fail.


> +       if (!consume(p, TOKEN_RBRACE, "expected '}'") || !consume(p, TOKEN_SEMICOLON, "expected ';'")) {
> +               err = -EINVAL;
> +               goto fail;
> +       }
> +
> +       ret->type = NODE_REGION;
> +       *node_ret = ret;
> +       return 0;
> +
> +fail:

parse_type() may allocate strings using strndup(), which also need to
be cleaned up here.

