Return-Path: <linux-kernel+bounces-898783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0DC56040
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C610E349EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2126320CBA;
	Thu, 13 Nov 2025 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gb2VBb1r"
Received: from sonic312-25.consmr.mail.gq1.yahoo.com (sonic312-25.consmr.mail.gq1.yahoo.com [98.137.69.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B13043BD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763017920; cv=none; b=hD9RkTCaXRHamObjWqj5V9IhH7VubieHa6OuRUOiEGtBAVf1S1S4Zsxafh5pCjAan6MKyT3QXcHVf/qGkOnNV9jMPOeFO3P6SW+K/vdT2IxIaXUmx7CB385ETkybn2Kmrm/uwQSDTgXWOhyFrl+UKOhppOql4rt65ttNMeKHbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763017920; c=relaxed/simple;
	bh=9mRkm0thRkAeL1Ah01Kul6o2+tcofOSucv8u+yexQwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvztXxiKPtkTwa57rMIoB/nrOPaCAS+YhBUVPfpnBqnop8E+vFbd12ut9PIsX7fTSjPyuVDQxFMdLpU0F8kKboo5dCkx1HJ5OK98gn8h+inuonVuB/E4pfMtR7iuTLLcdAQlMQpnQ/mtCFPYwZEwFl0OtJfQR7E/hHofA1tnrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Gb2VBb1r; arc=none smtp.client-ip=98.137.69.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763017918; bh=kx2Gc5JMZxIsn9Y/g/pzvq1ZU2AYiX6d4Mm9inJ05Qc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Gb2VBb1rodunOhX1prOITdbm2Ytg7rwxlszNmSB+SAWCOTJRIbxpGCr0RqR2BtIl6ygl5JVSe+Z3I6Im7BLQzgKSSOzAVCyls6R4MabYDrwgcEc4Y6WcQM6xWqxEB2vo+Ipj7HccLPRgK7jgE7volK4pyyj92a5Qms/++xlgqGMyT8Sq4pf81p6aqbB8xyRIkhXhsf0lr5AS3lznl+AsoVhVpq3qc+oPfcMWo2oLVNgK3ZdUJwn044MqrCYbwIwIG9Yx2dgkoB4E9km7vAbfssZepdy6RYAAn2PPaQ7mviuiXcgUWI9l0aBSM3n3OEoflH0y4FZ4yrbkvHvLRYRs2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763017918; bh=jHtQX+UGeUT0BN0NWWVj0uJ9i55REgNQ18dTZFcsfhG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=npchCPqN2eH9EpuTrAeE0QKVePyqdSMMpje/fXDAxPeLVAQuVHdt6sr7JGFPW2d1Fmbioca7Rt9Gos4IV2nNU4bMXasZTjqCXaBGTldHtjqMKrKHxGfb/T6YsOPZM1OKken/uvrvFH4IS5H5vZTCVGyvhDJKhhh7Mahp5k6vXcSpYOJ0S7CM1+/O8MG4vcw40hPhQ1BBgJYex4mNk3BO1WMBq+O0cv3+UMg3MT2vm7R472BJMiI2m/OHPPyS+vd+v4w3gRDZAZlm9DmR1+GrdggxNH2QiPZPSfn9AKKOLr0pdcJBwViVdif7L+WQyNvtP4PtkwJaWie5DiWX+5ZANg==
X-YMail-OSG: 1Vnvb5QVM1kFxSXi5ErfmFdf2QCETan4FtYdyQTiRg7bpeiBx4tHkWIpM.OeA0L
 4Ohg5OMZ0bqM1EdKjShltMIWEY6XjH3wSEoVehTc7HLB3G.DX3IjDYIlYYNdTJaDKhXrOxQZP_h_
 Mgh713Q7ITQgUPnlyM2uFs4Mq_YqlByTydHTzV4dVF5nPbvRn13VxvJoNlDJA.et1ToTLr_SNZAI
 QTNoYtd6S_CumD0vDvnShpsx5FsWwd5mfhK2GftIw772Rm9PrpTimcaS4aqemSzuxi8Eq60Ef9S0
 nub9EtWo87duHw.nuGjtxBKDvnZ.asulbODaFYBvkucELbXtmhcAcCQbn..hewsyoFWx2EWnbajR
 jpF8ftJDgQe8cEN9.S2a3lJRyDR_8QgKAiOATJYd_wkr_RqrVLTm.6tdZ4y01ABqqX1ZsdEZes40
 ns.eT8QcFhPvgglxLHZB9tcC7ElqMiywMgJXDL3gBy_7J6hwvFJWKlxRNmpIIsUKgkUSsFtav_qL
 GY.eP6r8q2irBPg0MqTCtUb7VDX8yklRf958HS8Iq6pKH.di8v7h7u9NrwwsNi.s4m9dvz8Caz8q
 fodVHleAXV_cQqXsCCIUgYPxojX.KRg1PIOuOjELWPsxJB.FtDwvx5yDHtHrLXufFQ4v6erKodfT
 3w4ddqIUj3CCoDGWz3IMARVicTuHZ.2gSGAe5nSmkyMOhSWJ6IcbR8ITPcksFPPv9h4ZvUMKSYQf
 01Ma0ucJA.4IUvz7D06sFnm.gJuuudcAvXMK9lckGo5MIpLmImJUzoO02ecl40Dho4C12dHKM8RO
 zz_kBd_wys5QDNDOn092hnsrG9HfcqcOab.k3.RT_iqiesEPP3XS9xbD.5AJCODaSzeJ4jFF8ren
 eSWrfo8ZWdLeMO9LN6EYaI9H5jBKeFT61Kk_9gwScdWXvfWJRcwuGDwqUIhPYF.HEK09wUsVTo8G
 ro4T6i5YEONMJqQwzlvlnDANywf7BbhDEGnmGhKeVaWxAuFZnVRFXBUrM1gHkJH5ktHlMRDh5Pya
 h69N4BcXXx9nTL27OiX_6ev7bnUBANZhMfakVS_yd8OnBPc9l.__vJMQ2m_mcrACZTbDht3NN_hh
 OWbrcuw9f4ZCbxP_IvOZyD4e9zCjuEA9vkAqadaRevvHtOrrtOpG3B4CiouJQ1fbjUt6yDct9NV.
 W74vYX7ueWzOcFWTfRQ0D3loG.Qg6LzNlAaCse0jcKIoo.U78eewCxHwCJfNO6m.ObqHhkC4FfCW
 nVXhb2q_Kimpz64Vd38gsbec9KvhyhpEXMdRXpvXUZn.R5Z_LMJUt5RsJeSrlxKcRBXA1MwgPZaY
 iAJ78L6rCukw8T14vElmvhzEBmJV8cv56SVYDX7iPRba7Ym0qwYg_kPesjs0ogJF3EXwEh0pSqqr
 hzy5zbd9wix5joMYmkjIGXFW7.4BfXN46ESD1rFqBWK7.F3HG5Xw1pl6JcjgzhpjMkheqYC3wDZG
 TYdeayZ0pQkyM4nRHxLNdXrOb8jGVItcBJsnq0q7aCp7o1si7bkoKizZgcx7ZVGczMneW5aSgd_y
 aqwO6Y9vrJtrQbyLDeUygS7VZ8rWnZc3Rhem4t69aG7a0ZDIBx9DkRKJFmO5SBHGL3mgPkKwNhaT
 NJCpaovcoWXyABvnn38cxc92Nj7k15xIb2SCx2atLwMtyePgU2j5NbF8SgLMCVqV1TSX5xgthTEr
 pArYJ8lTjDg.bzwb1vrB76bUfQoL6qFSJKkizzcOJ.PJxm4RcS4JknOQrrsHPyB5QO.QCjNsK2hq
 rc_qIu0VNzCbg2zdJq_4H_fx9HQKNdgVS6wi1Tb9Ly7soZLA.Yw2zkCFyZqWpgkr3C.7RjwcHn1d
 0UkVLwMKTNMMdwSpnyg2yiQsvJKsc08f3k4W60xbt1wDDIf1phpnSuXS6DAiZ2iWxGbYZCOng6T0
 QLP.xYamYY3wKygY8VK86_J1r7wH0ChBfcjra6Wvs8.F5ZB2R8cnEzsxOL0va8HYRVNyXI1KSrtq
 h7kGjwQfXnqfLWPu4vTUPWozNuc4bWBvKgEp30zEDBW65k4e.rmk2KziUBrA7hWqqGkvEX9UKzEr
 pqRawkR_pkDMCy1n6COX0uqlmTA7B8xeJSYjbMi8iaYyWn_1T4.tLz5_P4E8_MBtxxMS4mGHESgc
 G7QswjEXJSY4uJt.2c23LeYlXbS4uLxyBo2PHjIwo2UjEU91XUwNZf5.KU5NTHDmGtObBFDGt.Km
 y94ifyZ1A0Rt9twiPbzblOxfMyrDsGBBtgWZyGeAtmWs-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 25bb90e9-018e-4e72-87d4-c2dbc32102c2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 07:11:58 +0000
Received: by hermes--production-bf1-58477f5468-xwsfb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7988a6bd19b29596b4f47d1e6b68cb03;
          Thu, 13 Nov 2025 06:41:35 +0000 (UTC)
Message-ID: <335f64d5-390b-4529-b2da-0af019c7f598@yahoo.com>
Date: Thu, 13 Nov 2025 07:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251112212026.31441-1-adelodunolaoluwa.ref@yahoo.com>
 <20251112212026.31441-1-adelodunolaoluwa@yahoo.com>
 <CAAVpQUB97EBnTbA9pKwdhPM0pHadiM3QhP4_1qLSKGg2LAwzkA@mail.gmail.com>
 <295e5440-94eb-447f-b4f0-4943e9d02f1c@yahoo.com>
 <CAAVpQUAyPwyG=aSnv-2w7g3dqhB3BLXGoo5VmbSNqQ0txpqqWQ@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUAyPwyG=aSnv-2w7g3dqhB3BLXGoo5VmbSNqQ0txpqqWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/13/25 07:10, Kuniyuki Iwashima wrote:
> On Wed, Nov 12, 2025 at 9:25 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> On 11/12/25 23:04, Kuniyuki Iwashima wrote:
>>> On Wed, Nov 12, 2025 at 1:20 PM Sunday Adelodun
>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>> Add selftests to verify and document Linux’s intended behaviour for
>>>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>>>> The tests verify that:
>>>>
>>>>    1. SOCK_STREAM returns EOF when the peer closes normally.
>>>>    2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>>>>    3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>>    4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>>    5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>>
>>>> This follows up on review feedback suggesting a selftest to clarify
>>>> Linux’s semantics.
>>>>
>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>>>> ---
>>>>    tools/testing/selftests/net/.gitignore        |   1 +
>>>>    tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>>>    .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++++
>>>>    3 files changed, 180 insertions(+)
>>>>    create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>
>>>> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
>>>> index 439101b518ee..e89a60581a13 100644
>>>> --- a/tools/testing/selftests/net/.gitignore
>>>> +++ b/tools/testing/selftests/net/.gitignore
>>>> @@ -65,3 +65,4 @@ udpgso
>>>>    udpgso_bench_rx
>>>>    udpgso_bench_tx
>>>>    unix_connect
>>>> +unix_connreset
>>>> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
>>>> index de805cbbdf69..5826a8372451 100644
>>>> --- a/tools/testing/selftests/net/af_unix/Makefile
>>>> +++ b/tools/testing/selftests/net/af_unix/Makefile
>>>> @@ -7,6 +7,7 @@ TEST_GEN_PROGS := \
>>>>           scm_pidfd \
>>>>           scm_rights \
>>>>           unix_connect \
>>>> +       unix_connreset \
>>>>    # end of TEST_GEN_PROGS
>>>>
>>>>    include ../../lib.mk
>>>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>> new file mode 100644
>>>> index 000000000000..9413f8a0814f
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>> @@ -0,0 +1,178 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>>>> + *
>>>> + * This test verifies:
>>>> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
>>>> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
>>>> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>> + *
>>>> + * These tests document the intended Linux behaviour.
>>>> + *
>>>> + */
>>>> +
>>>> +#define _GNU_SOURCE
>>>> +#include <stdlib.h>
>>>> +#include <string.h>
>>>> +#include <fcntl.h>
>>>> +#include <unistd.h>
>>>> +#include <errno.h>
>>>> +#include <sys/socket.h>
>>>> +#include <sys/un.h>
>>>> +#include "../../kselftest_harness.h"
>>>> +
>>>> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
>>>> +
>>>> +static void remove_socket_file(void)
>>>> +{
>>>> +       unlink(SOCK_PATH);
>>>> +}
>>>> +
>>>> +FIXTURE(unix_sock)
>>>> +{
>>>> +       int server;
>>>> +       int client;
>>>> +       int child;
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT(unix_sock)
>>>> +{
>>>> +       int socket_type;
>>>> +       const char *name;
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>>>> +       .socket_type = SOCK_STREAM,
>>>> +       .name = "SOCK_STREAM",
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>>>> +       .socket_type = SOCK_DGRAM,
>>>> +       .name = "SOCK_DGRAM",
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
>>>> +       .socket_type = SOCK_SEQPACKET,
>>>> +       .name = "SOCK_SEQPACKET",
>>>> +};
>>>> +
>>>> +FIXTURE_SETUP(unix_sock)
>>>> +{
>>>> +       struct sockaddr_un addr = {};
>>>> +       int err;
>>>> +
>>>> +       addr.sun_family = AF_UNIX;
>>>> +       strcpy(addr.sun_path, SOCK_PATH);
>>>> +       remove_socket_file();
>>>> +
>>>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>>>> +       ASSERT_LT(-1, self->server);
>>>> +
>>>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>>>> +       ASSERT_EQ(0, err);
>>>> +
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>> +               err = listen(self->server, 1);
>>>> +               ASSERT_EQ(0, err);
>>>> +       }
>>>> +
>>>> +       self->client = socket(AF_UNIX, variant->socket_type | SOCK_NONBLOCK, 0);
>>>> +       ASSERT_LT(-1, self->client);
>>>> +
>>>> +       err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>>>> +       ASSERT_EQ(0, err);
>>>> +}
>>>> +
>>>> +FIXTURE_TEARDOWN(unix_sock)
>>>> +{
>>>> +       if ((variant->socket_type == SOCK_STREAM ||
>>>> +            variant->socket_type == SOCK_SEQPACKET) & self->child > 0)
>>>> +               close(self->child);
>>>> +
>>>> +       close(self->client);
>>>> +       close(self->server);
>>>> +       remove_socket_file();
>>>> +}
>>>> +
>>>> +/* Test 1: peer closes normally */
>>>> +TEST_F(unix_sock, eof)
>>>> +{
>>>> +       char buf[16] = {};
>>>> +       ssize_t n;
>>>> +
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>> +               self->child = accept(self->server, NULL, NULL);
>>>> +               ASSERT_LT(-1, self->child);
>>>> +
>>>> +               close(self->child);
>>>> +       } else {
>>>> +               close(self->server);
>>>> +       }
>>>> +
>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>> +
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>> +               ASSERT_EQ(0, n);
>>>> +       } else {
>>>> +               ASSERT_EQ(-1, n);
>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>> +       }
>>>> +}
>>>> +
>>>> +/* Test 2: peer closes with unread data */
>>>> +TEST_F(unix_sock, reset_unread_behavior)
>>>> +{
>>>> +       char buf[16] = {};
>>>> +       ssize_t n;
>>>> +
>>>> +       if (variant->socket_type == SOCK_DGRAM) {
>>>> +               /* No real connection, just close the server */
>>>> +               close(self->server);
>>>> +       } else {
>>>> +               /* Establish full connection first */
>>>> +               self->child = accept(self->server, NULL, NULL);
>>>> +               ASSERT_LT(-1, self->child);
>>>> +
>>>> +               /* Send data that will remain unread */
>>>> +               send(self->client, "hello", 5, 0);
>>> Could you move this send() before "if (...)" because we want
>>> to test unread_data behaviour for SOCK_DGRAM too ?
>>>
>>> Otherwise looks good, so with that fixed:
>>>
>>> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>
>>> Thanks!
>> Thank you for the prompt response.
>> I thought of putting the send before the if the statement , but I was afraid
>> STREAM and SEQPACKET connections won't be accepted before data sending.
> connect() create the paired child socket and accept()
> allocates a file descriptor to expose the socket to user
> space.
Thank you for this explanation.
>
> In that sense, the comment above accept() sounds a
> bit weird ;)
I understand.
I am changing it to
/* Accept client connection */

If this is accepted, I will send v5 immediately

Thank you for your guidance.
>
>
>> I will start working on v5.
>>
>> That part will look like this now:
>> /* Test 2: peer closes with unread data */
>> TEST_F(unix_sock, reset_unread_behavior)
>> {
>>           char buf[16] = {};
>>           ssize_t n;
>>
>> */* Send data that will remain unread */
>>           send(self->client, "hello", 5, 0);*
>>
>> *if (variant->socket_type == SOCK_DGRAM) {
>>                   /* No real connection, just close the server */
>>                   close(self->server);
>>           } else {
>>                   /* Establish full connection first */
>>                   self->child = accept(self->server, NULL, NULL);
>>                   ASSERT_LT(-1, self->child);
>>
>>                   /* Peer closes before client reads */
>>                   close(self->child);
>>           }*
>>
>>           n = recv(self->client, buf, sizeof(buf), 0);
>>           ASSERT_EQ(-1, n);
>>
>>           if (variant->socket_type == SOCK_STREAM ||
>>               variant->socket_type == SOCK_SEQPACKET) {
>>                   ASSERT_EQ(ECONNRESET, errno);
>>           } else {
>>                   ASSERT_EQ(EAGAIN, errno);
>>           }
>> }
>>
>> Thank you once again.
>>>
>>>> +
>>>> +               /* Peer closes before client reads */
>>>> +               close(self->child);
>>>> +       }
>>>> +
>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>> +       ASSERT_EQ(-1, n);
>>>> +
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>> +               ASSERT_EQ(ECONNRESET, errno);
>>>> +       } else {
>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>> +       }
>>>> +}
>>>> +
>>>> +/* Test 3: closing unaccepted (embryo) server socket should reset client. */
>>>> +TEST_F(unix_sock, reset_closed_embryo)
>>>> +{
>>>> +       char buf[16] = {};
>>>> +       ssize_t n;
>>>> +
>>>> +       if (variant->socket_type == SOCK_DGRAM)
>>>> +               SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");
>>>> +
>>>> +       /* Close server without accept()ing */
>>>> +       close(self->server);
>>>> +
>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>> +
>>>> +       ASSERT_EQ(-1, n);
>>>> +       ASSERT_EQ(ECONNRESET, errno);
>>>> +}
>>>> +
>>>> +TEST_HARNESS_MAIN
>>>> +
>>>> --
>>>> 2.43.0
>>>>


